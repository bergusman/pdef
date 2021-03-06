# encoding: utf-8
import logging
from collections import OrderedDict
from pdef import ast
from pdef.common import Type, PdefException
from pdef.preconditions import check_isinstance, check_state


class Base(object):
    '''Abstract base symbol which has a location and error checks.'''
    location = None

    def _check(self, expression, msg, *args):
        if expression: return

        msg = msg % args if msg else 'Error'
        if self.location:
            msg = '%s: %s' % (self.location, msg)
        raise PdefException(msg)


class Pdef(Base):
    '''Protocol definition.'''
    def __init__(self):
        self.modules = SymbolTable(self, name='modules')

    def __str__(self):
        return 'Pdef'

    def add_module(self, module):
        '''Adds a new module to Pdef.'''
        self._check(module.pdef is None, '%s is already added to another pdef instance', module)
        module.pdef = self
        self.modules.add(module)
        logging.debug('%s: added a module "%s"', self, module)

    def add_file_node(self, file_node):
        '''Adds a new file AST node, returns a tuple (module, added_definitions).'''
        module = Module.from_ast(file_node)
        self.add_module(module)

        return module, tuple(module.definitions.values())

    def link(self):
        for module in self.modules.values():
            module.link_imports()

        for module in self.modules.values():
            module.link_definitions()
        logging.debug('%s: linked', self)

    def get_module(self, name):
        '''Returns a module by its name, or raises and exception.'''
        module = self.modules.get(name)
        if not module: raise PdefException('%s: module %r is not found' % (self, name))
        return module


class Module(Base):
    '''Module in a protocol definition.'''
    @classmethod
    def from_ast(cls, node):
        '''Creates a new module from an AST node.'''
        module = Module(node.name)
        module._node = node
        module.location = node.location

        for def_node in node.definitions:
            def0 = Definition.from_ast_polymorphic(def_node)
            module.add_definition(def0)

        return module

    def __init__(self, name):
        self.name = name
        self.definitions = SymbolTable(self, 'definitions')
        self.imported_definitions = SymbolTable(self, 'imported_definitions')
        self.pdef = None

        self._node = None
        self._imports_linked = False
        self._defs_linked = False

    def __repr__(self):
        return '<%s %s>' % (self.__class__.__name__, self.name)

    def __str__(self):
        return self.name

    def link_imports(self):
        '''Links this method imports, must be called before link_definitions().'''
        if self._imports_linked: return
        self._imports_linked = True
        if not self._node: return

        pdef = self.pdef
        self._check(pdef is not None, '%s: cannot link, pdef is required', self)

        for node in self._node.imports:
            module = pdef.get_module(node.module_name)
            for name in node.names:
                try:
                    def0 = module.get_definition(name)
                except PdefException:
                    raise PdefException('%s: import %r is not found in %s' % (self, name, module))
                self.add_import(def0)

        logging.debug('%s: linked imports', self)

    def link_definitions(self):
        '''Links this module definitions, must be called after link_imports().'''
        if self._defs_linked: return
        self._defs_linked = True

        for definition in self.definitions.values():
            definition.link()

        logging.debug('%s: linked definitions', self)

    def add_import(self, definition):
        '''Adds an imported definition to this module.'''
        check_isinstance(definition, Definition)
        self.imported_definitions.add(definition)

    def add_definition(self, definition):
        '''Adds a new definition to this module.'''
        check_isinstance(definition, Definition)
        self._check(definition.module is None, '%s is already added to another module', definition)
        self._check(definition.name not in self.imported_definitions,
                    '%s: definition %r clashes with an import' % (self, definition.name))

        definition.module = self
        self.definitions.add(definition)
        logging.debug('%s: added a definition "%s"', self, definition)

    def add_definitions(self, *definitions):
        '''Adds all definitions to this module.'''
        map(self.add_definition, definitions)

    def get_definition(self, name):
        '''Returns a definition by its name, or raises an exception.'''
        def0 = self.definitions.get(name)
        if not def0: raise PdefException('%s: definitions %r is not found' % (self, name))
        return def0

    def lookup(self, ref_or_def):
        '''Lookups a definition if a reference, then links the definition, and returns it.'''
        if isinstance(ref_or_def, Definition):
            def0 = ref_or_def
        elif isinstance(ref_or_def, ast.Ref):
            def0 = self._lookup_ref(ref_or_def)
        else:
            raise PdefException('%s: unsupported lookup reference or definition %r' %
                                (self, ref_or_def))

        def0.link()
        return def0

    def _lookup_ref(self, ref):
        def0 = Types.get_by_type(ref.type)
        if def0: return def0 # It's a simple value.

        t = ref.type
        if t == Type.LIST: return List(ref.element, module=self)
        elif t == Type.SET: return Set(ref.element, module=self)
        elif t == Type.MAP: return Map(ref.key, ref.value, module=self)
        elif t == Type.ENUM_VALUE:
            enum = self.lookup(ref.enum)
            value = enum.values.get(ref.value)
            if not value:
                raise PdefException('%s: enum value "%s" is not found' % (self, ref))
            return value

        # It must be an import or a user defined type.
        name = ref.name
        if name in self.imported_definitions: return self.imported_definitions[name]
        if name in self.definitions: return self.definitions[name]
        raise PdefException('%s: type "%s" is not found' % (self, ref))


class Definition(Base):
    '''Base definition.'''
    @classmethod
    def from_ast_polymorphic(cls, node):
        '''Creates a new definition from an AST node, supports enums, messages and interfaces.'''
        if node.type == Type.ENUM:
            return Enum.from_ast(node)
        elif node.type == Type.MESSAGE:
            return Message.from_ast(node)
        elif node.type == Type.INTERFACE:
            return Interface.from_ast(node)

        raise ValueError('Unsupported definition node %s' % node)

    def __init__(self, type, name, doc=None):
        self.type = type
        self.name = name
        self.module = None
        self.doc = doc
        self._linked = False

    def __repr__(self):
        return '<%s %s>' % (self.__class__.__name__, self.fullname)

    def __str__(self):
        return self.fullname

    @property
    def is_primitive(self):
        return self.type in Type.PRIMITIVES

    @property
    def is_datatype(self):
        return self.type in Type.DATATYPES

    @property
    def fullname(self):
        if self.module:
            return '%s.%s' % (self.module.name, self.name)
        return self.name

    def link(self):
        if self._linked:
            return

        self._linked = True
        self._link()

    def _link(self):
        pass


class NativeType(Definition):
    '''Native type definition, i.e. it defines a native language type such as string, int, etc.'''
    def __init__(self, type):
        super(NativeType, self).__init__(type, type)
        self.type = type


class Types(object):
    '''Native types.'''
    BOOL = NativeType(Type.BOOL)
    INT16 = NativeType(Type.INT16)
    INT32 = NativeType(Type.INT32)
    INT64 = NativeType(Type.INT64)
    FLOAT = NativeType(Type.FLOAT)
    DOUBLE = NativeType(Type.DOUBLE)
    DECIMAL = NativeType(Type.DECIMAL)
    DATE = NativeType(Type.DATE)
    DATETIME = NativeType(Type.DATETIME)
    STRING = NativeType(Type.STRING)
    UUID = NativeType(Type.UUID)

    OBJECT = NativeType(Type.OBJECT)
    VOID = NativeType(Type.VOID)

    _BY_TYPE = None

    @classmethod
    def get_by_type(cls, t):
        '''Returns a value by its type or none.'''
        if cls._BY_TYPE is None:
            cls._BY_TYPE = {}
            for k, v in cls.__dict__.items():
                if not isinstance(v, NativeType): continue
                cls._BY_TYPE[v.type] = v

        return cls._BY_TYPE.get(t)


class List(Definition):
    '''List definition.'''
    def __init__(self, element, module=None):
        super(List, self).__init__(Type.LIST, 'List')
        self.element = element
        self.module = module
        self._check(self.element.is_datatype, '%s: element must be a data type, %s',
                    self, self.element)

    def _link(self):
        self.element = self.module.lookup(self.element)


class Set(Definition):
    '''Set definition.'''
    def __init__(self, element, module=None):
        super(Set, self).__init__(Type.SET, 'Set')
        self.element = element
        self.module = module
        self._check(self.element.is_datatype, '%s: element must be a data type, %s',
                    self, self.element)

    def _link(self):
        self.element = self.module.lookup(self.element)


class Map(Definition):
    '''Map definition.'''
    def __init__(self, key, value, module=None):
        super(Map, self).__init__(Type.MAP, 'Map')
        self.key = key
        self.value = value
        self.module = module

        self._check(self.key.is_primitive, '%s: key must be a primitive, %s', self, self.key)
        self._check(self.value.is_datatype, '%s: value must be a data type, %s', self, self.value)

    def _link(self):
        self.key = self.module.lookup(self.key)
        self.value = self.module.lookup(self.value)


class Enum(Definition):
    '''Enum definition.'''
    @classmethod
    def from_ast(cls, node):
        check_isinstance(node, ast.Enum)
        enum = Enum(node.name, *node.values)
        enum.doc = node.doc
        enum.location = node.location
        return enum

    def __init__(self, name, *values):
        super(Enum, self).__init__(Type.ENUM, name)
        self.values = SymbolTable(self, 'values')
        if values:
            self.add_values(*values)

    def add_value(self, value_name):
        '''Creates a new enum value by its name, adds it to this enum, and returns it.'''
        value = EnumValue(self, value_name)
        self.values.add(value)
        return value

    def add_values(self, *value_names):
        map(self.add_value, value_names)

    def __contains__(self, item):
        return item in self.values.values()


class EnumValue(Definition):
    '''Single enum value which has a name and a pointer to the declaring enum.'''
    def __init__(self, enum, name):
        super(EnumValue, self).__init__(Type.ENUM_VALUE, name)
        self.enum = enum
        self.name = name


class Message(Definition):
    '''User-defined message.'''
    @classmethod
    def from_ast(cls, node):
        '''Creates a new unlinked message from an AST node.'''
        check_isinstance(node, ast.Message)
        msg = Message(node.name, is_exception=node.is_exception, doc=node.doc)
        msg._node = node
        msg.location = node.location
        return msg

    def __init__(self, name, is_exception=False, doc=None):
        super(Message, self).__init__(Type.MESSAGE, name, doc=doc)
        self.is_exception = is_exception

        self.base = None
        self.base_type = None
        self.subtypes = OrderedDict()
        self.discriminator = None

        self.fields = SymbolTable(self, 'fields')
        self.declared_fields = SymbolTable(self, 'declared_fields')
        self.inherited_fields = SymbolTable(self, 'inherited_fields')

        self._node = None

    @property
    def polymorphic_discriminator(self):
        '''Returns this message discriminator field, base discriminator field, or None.'''
        return self.discriminator if self.discriminator \
            else self.base.discriminator if self.base else None

    def set_base(self, base, base_type=None):
        '''Sets this message base and inherits its fields.

        The base_type must be present when a polymorphic base message is inherited
        (a message with a discriminator field) and vice versa.
        '''
        check_isinstance(base, Message)
        self._check(self != base, '%s: cannot inherit itself', self)
        self._check(self not in base._bases, '%s: circular inheritance with %s', self, base)
        self._check(self.is_exception == base.is_exception, '%s: cannot inherit %s',
                    self, base.fullname)

        self.base = base
        if base_type:
            check_isinstance(base_type, EnumValue)
            self._check(base.polymorphic_discriminator,
                        '%s: polymorphic inheritance of a non-polymorphic base %s', self, base)
            self.base_type = base_type
            self.base._add_subtype(self)
        else:
            self._check(not base.polymorphic_discriminator,
                        '%s: non-polymorphic inheritance of a polymorphic base %s', self, base)

        for field in base.fields.values():
            self.inherited_fields.add(field)
            self.fields.add(field)

        logging.debug('%s: set base to "%s"', self, base)

    def _add_subtype(self, subtype):
        '''Adds a new subtype to this message, checks its base_type.'''
        check_isinstance(subtype, Message)
        self._check(self.polymorphic_discriminator,
                    '%s: is not polymorphic, no discriminator field', self)
        self._check(subtype.base_type in self.polymorphic_discriminator.type,
                    '%s: wrong polymorphic enum value', self)
        self._check(subtype.base_type not in self.subtypes, '%s: duplicate subtype %s',
                    self, subtype.base_type)

        self.subtypes[subtype.base_type] = subtype
        if self.base and self.base.discriminator == self.polymorphic_discriminator:
            self.base._add_subtype(subtype)

    def add_field(self, name, definition, is_discriminator=False):
        '''Adds a new field to this message and returns the field.'''
        self._check(definition.is_datatype, '%s: field must be a data type, "%s", %s',
                    self, name, definition)

        field = Field(self, name, definition, is_discriminator)
        self.declared_fields.add(field)
        self.fields.add(field)

        if is_discriminator:
            self._check(not self.discriminator, '%s: duplicate discriminator field "%s"', self, name)
            self._check(isinstance(field.type, Enum),
                        '%s: discriminator field must be an enum "%s"', self, name)
            self._check(not self.subtypes,
                        '%s: discriminator field must be set before adding subtypes', self)
            self.discriminator = field

        logging.debug('%s: added a field "%s"', self, field)
        return field

    def _link(self):
        '''Initializes this message from its AST node if present.'''
        node = self._node
        if not node: return

        module = self.module
        self._check(module, '%: cannot link, module is required', self)

        if node.base:
            base = module.lookup(node.base)
            base_type = module.lookup(node.base_type) if node.base_type else None
            self.set_base(base, base_type)

        for field_node in node.fields:
            fname = field_node.name
            ftype = module.lookup(field_node.type)
            self.add_field(fname, ftype, field_node.is_discriminator)

        logging.debug('%s: linked', self)

    @property
    def _bases(self):
        '''Internal, returns all this message bases.'''
        bases = []

        b = self
        while b.base:
            bases.append(b.base)
            b = b.base

        return bases


class Field(object):
    '''Single message field.'''
    def __init__(self, message, name, type, is_discriminator=False):
        self.message = message
        self.name = name
        self.type = type
        self.is_discriminator = is_discriminator
        check_isinstance(type, Definition)

    def __repr__(self):
        return '%s %s' % (self.name, self.type)

    @property
    def fullname(self):
        return '%s.%s=%s' % (self.message.fullname, self.name, self.type)


class Interface(Definition):
    '''User-defined interface.'''
    @classmethod
    def from_ast(cls, node):
        '''Creates a new interface from an AST node.'''
        check_isinstance(node, ast.Interface)
        iface = Interface(node.name, doc=node.doc)
        iface._node = node
        iface.location = node.location
        return iface

    def __init__(self, name, doc=None):
        super(Interface, self).__init__(Type.INTERFACE, name, doc=doc)

        self.base = None
        self.methods = SymbolTable(self, 'methods')
        self.declared_methods = SymbolTable(self, 'declared_methods')
        self.inherited_methods = SymbolTable(self, 'inherited_methods')

        self._node = None

    def set_base(self, base):
        '''Set the base of this interface.'''
        check_isinstance(base, Interface)
        self._check(base is not self, '%s: self inheritance', self)
        self._check(self not in base._all_bases, '%s: circular inheritance with %s', self, base)

        self.base = base
        for method in base.methods.values():
            self.inherited_methods.add(method)
            self.methods.add(method)

        logging.debug('%s: set a base "%s"', self, base)

    def add_method(self, name, result=Types.VOID, *args_tuples):
        '''Adds a new method to this interface and returns the method.'''
        method = Method(self, name, result, args_tuples)
        self.declared_methods.add(method)
        self.methods.add(method)
        logging.debug('%s: added a method "%s"', self, method)
        return method

    def _link(self):
        '''Initializes this interface from its AST node if present.'''
        node = self._node
        if not node: return

        module = self.module
        self._check(module, '%: cannot link, module is required', self)

        if node.base:
            base = module.lookup(node.base)
            self.set_base(base)

        for method_node in node.methods:
            method_name = method_node.name
            result = module.lookup(method_node.result)
            args = []
            for arg_node in method_node.args:
                arg_name = arg_node.name
                arg_type = module.lookup(arg_node.type)
                args.append((arg_name, arg_type))

            method = self.add_method(method_name, result, *args)
            method.doc = method_node.doc

        logging.debug("%s: linked", self)

    @property
    def _all_bases(self):
        '''Internal, returns all bases including the ones from the inherited interfaces.'''
        bases = []
        b = self.base
        while b:
            bases.append(b)
            b = b.base
        return bases


class Method(object):
    '''Interface method.'''
    def __init__(self, interface, name, result, args_tuples=None, doc=None):
        self.interface = interface
        self.name = name
        self.result = result
        self.doc = doc
        self.args = SymbolTable(self, 'args')
        for arg_name, arg_def in args_tuples:
            self.args.add(MethodArg(arg_name, arg_def))

        check_isinstance(result, Definition)

    def __str__(self):
        return '%s(%s)=>%s' % (self.name, ', '.join(str(a) for a in self.args.values()), self.result)

    @property
    def fullname(self):
        return '%s.%s' % (self.interface.fullname, self)


class MethodArg(object):
    '''Single method argument.'''
    def __init__(self, name, definition):
        self.name = name
        self.type = definition
        check_isinstance(definition, Definition)

    def __repr__(self):
        return '%s %s' % (self.name, self.type)


class SymbolTable(OrderedDict):
    '''SymbolTable is an ordered dict which supports adding items using item.name as a key,
    and prevents duplicate items.'''
    def __init__(self, parent=None, name='items', *args, **kwds):
        super(SymbolTable, self).__init__(*args, **kwds)
        self.parent = parent
        self.name = name

    def add(self, item):
        '''Adds an item by with item.name as the key.'''
        self[item.name] = item

    def __setitem__(self, key, value):
        check_state(key not in self, '%s.%s: duplicate %s', self.parent, self.name, key)
        super(SymbolTable, self).__setitem__(key, value)
