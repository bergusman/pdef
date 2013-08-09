//
//  PDDescriptors.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDDescriptors.h"
#import "PDException.h"

#pragma mark - Bool Descriptor

@interface PDBoolPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDBoolPrimitiveDescriptor

- (NSNumber *)default {
    return @NO;
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @NO;
    }
    if ([object isEqual:[NSNull null]]) {
        return @NO;
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object boolValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object boolValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @NO;
    }
    if ([object isEqual:[NSNull null]]) {
        return @NO;
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object boolValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @NO;
    }
    if ([string isEqual:[NSNull null]]) {
        return @NO;
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([string boolValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"false";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"false";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [object boolValue] ? @"true" : @"false";
}

@end

#pragma mark - Int16 Descriptor

@interface PDInt16PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDInt16PrimitiveDescriptor

- (NSNumber *)default {
    return @((short)0);
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @((short)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((short)0);
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object shortValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @((short)[object intValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @((short)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((short)0);
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object shortValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @((short)0);
    }
    if ([string isEqual:[NSNull null]]) {
        return @((short)0);
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @((short)[string intValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"0";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"0";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [@([object shortValue]) stringValue];
}

@end

#pragma mark - Int32 Descriptor

@interface PDInt32PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDInt32PrimitiveDescriptor

- (NSNumber *)default {
    return @((int)0);
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @((int)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((int)0);
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object intValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object intValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @((int)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((int)0);
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object intValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @((int)0);
    }
    if ([string isEqual:[NSNull null]]) {
        return @((int)0);
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([string intValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"0";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"0";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [@([object intValue]) stringValue];
}

@end

#pragma mark - Int64 Descriptor

@interface PDInt64PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDInt64PrimitiveDescriptor

- (NSNumber *)default {
    return @((long long)0);
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @((long long)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((long long)0);
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object longLongValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object longLongValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @((long long)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((long long)0);
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object longLongValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @((long long)0);
    }
    if ([string isEqual:[NSNull null]]) {
        return @((long long)0);
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([string longLongValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"0";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"0";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [@([object longLongValue]) stringValue];
}

@end

#pragma mark - Float Descriptor

@interface PDFloatPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDFloatPrimitiveDescriptor

- (NSNumber *)default {
    return @((float)0);
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @((float)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((float)0);
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object floatValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object floatValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @((float)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((float)0);
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object floatValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @((float)0);
    }
    if ([string isEqual:[NSNull null]]) {
        return @((float)0);
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([string floatValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"0";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"0";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [@([object floatValue]) stringValue];
}

@end

#pragma mark - Double Descriptor

@interface PDDoublePrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDDoublePrimitiveDescriptor

- (NSNumber *)default {
    return @((double)0);
}

- (NSNumber *)parse:(id)object {
    if (!object) {
        return @((double)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((double)0);
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object doubleValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object doubleValue]);
    }
    [NSException raise:PDCastException format:nil];
    return nil;
}

- (NSNumber *)serialize:(NSNumber *)object {
    if (!object) {
        return @((double)0);
    }
    if ([object isEqual:[NSNull null]]) {
        return @((double)0);
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([object doubleValue]);
}

- (NSNumber *)parseFromString:(NSString *)string {
    if (!string) {
        return @((double)0);
    }
    if ([string isEqual:[NSNull null]]) {
        return @((double)0);
    }
    if (![string isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return @([string doubleValue]);
}

- (NSString *)serializeToString:(NSNumber *)object {
    if (!object) {
        return @"0";
    }
    if ([object isEqual:[NSNull null]]) {
        return @"0";
    }
    if (![object isKindOfClass:[NSNumber class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return [@([object doubleValue]) stringValue];
}

@end

#pragma mark - String Descriptor

@interface PDStringPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDStringPrimitiveDescriptor

- (id)default {
    return nil;
}

- (id)parse:(id)object {
    if (!object) {
        return nil;
    }
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    if (![object isKindOfClass:[NSString class]]) {
        [NSException raise:PDCastException format:nil];
    }
    return object;
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @((double)(object ? [object doubleValue] : 0));
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @((double)(string ? [string doubleValue] : 0));
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@((double)(object ? [object doubleValue] : 0)) stringValue];
}

@end

#pragma mark - List Descriptor

@interface PDListDescriptor : NSObject <PDDescriptor>

- (id)initWithElementDescriptor:(id<PDDescriptor>)elementDescriptor;

@end

@implementation PDListDescriptor {
    id<PDDescriptor> _elementDescriptor;
}

- (id)initWithElementDescriptor:(id<PDDescriptor>)elementDescriptor {
    if (!elementDescriptor) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    self = [super init];
    if (self) {
        _elementDescriptor = elementDescriptor;
    }
    return self;
}

- (id)default {
    return @[];
}

- (id)parse:(id)object {
    if (!object) {
        return nil;
    }
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    if (![object isKindOfClass:[NSArray class]]) {
        [NSException raise:PDCastException format:nil];
    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[object count]];
    for (id item in object) {
        id resultItem = [_elementDescriptor parse:item];
        if (resultItem) {
            [result addObject:resultItem];
        }
    }
    return [result copy];
}

- (id)serialize:(id)object {
    if (!object) {
        return nil;
    }
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    if (![object isKindOfClass:[NSArray class]]) {
        [NSException raise:PDCastException format:nil];
    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[object count]];
    for (id item in object) {
        id resultItem = [_elementDescriptor serialize:item];
        if (resultItem) {
            [result addObject:resultItem];
        }
    }
    return [result copy];
}

@end

#pragma mark - Set Descriptor

@interface PDSetDescriptor : NSObject <PDDescriptor>

- (id)initWithElementDescriptor:(id<PDDescriptor>)elementDescriptor;

@end

@implementation PDSetDescriptor {
    id<PDDescriptor> _elementDescriptor;
}

- (id)initWithElementDescriptor:(id<PDDescriptor>)elementDescriptor {
    if (!elementDescriptor) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    self = [super init];
    if (self) {
        _elementDescriptor = elementDescriptor;
    }
    return self;
}

@end

#pragma mark - Map Descriptor

@interface PDMapDescriptor : NSObject <PDDescriptor>

- (id)initWithKeyDescriptor:(id<PDDescriptor>)keyDescriptor
            valueDescriptor:(id<PDDescriptor>)valueDescriptor;

@end

@implementation PDMapDescriptor {
    id<PDDescriptor> _keyDescriptor;
    id<PDDescriptor> _valueDescriptor;
}

- (id)initWithKeyDescriptor:(id<PDDescriptor>)keyDescriptor
            valueDescriptor:(id<PDDescriptor>)valueDescriptor
{
    if (!keyDescriptor) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    if (!valueDescriptor) {
        [NSException raise:NSInvalidArgumentException format:nil];
    }
    self = [super init];
    if (self) {
        _keyDescriptor = keyDescriptor;
        _valueDescriptor = valueDescriptor;
    }
    return self;
}

@end

#pragma mark - Void Descriptor

@interface PDVoidDescriptor : NSObject <PDDescriptor>

@end

@implementation PDVoidDescriptor

@end

#pragma mark - Descriptors

@interface PDDescriptors ()

@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> boolDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int16Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int32Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int64Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> floatDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> doubleDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> stringDescriptor;
@property (strong, nonatomic, readonly) id<PDDescriptor> voidDescriptor;

+ (PDDescriptors *)sharedDescriptors;

@end

@implementation PDDescriptors

- (id)init {
    self = [super init];
    if (self) {
        _boolDescriptor = [[PDBoolPrimitiveDescriptor alloc] init];
        _int16Descriptor = [[PDInt16PrimitiveDescriptor alloc] init];
        _int32Descriptor = [[PDInt32PrimitiveDescriptor alloc] init];
        _int64Descriptor = [[PDInt64PrimitiveDescriptor alloc] init];
        _floatDescriptor = [[PDFloatPrimitiveDescriptor alloc] init];
        _doubleDescriptor = [[PDDoublePrimitiveDescriptor alloc] init];
        _stringDescriptor = [[PDStringPrimitiveDescriptor alloc] init];
        _voidDescriptor = [[PDVoidDescriptor alloc] init];
    }
    return self;
}

+ (PDDescriptors *)sharedDescriptors {
    static PDDescriptors *_sharedDescriptors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDescriptors = [[PDDescriptors alloc] init];
    });
    return _sharedDescriptors;
}

+ (id<PDPrimitiveDescriptor>)boolDescriptor {
    return [[self sharedDescriptors] boolDescriptor];
}

+ (id<PDPrimitiveDescriptor>)int16Descriptor {
    return [[self sharedDescriptors] int16Descriptor];
}

+ (id<PDPrimitiveDescriptor>)int32Descriptor {
    return [[self sharedDescriptors] int32Descriptor];
}

+ (id<PDPrimitiveDescriptor>)int64Descriptor {
    return [[self sharedDescriptors] int64Descriptor];
}

+ (id<PDPrimitiveDescriptor>)floatDescriptor {
    return [[self sharedDescriptors] floatDescriptor];
}

+ (id<PDPrimitiveDescriptor>)doubleDescriptor {
    return [[self sharedDescriptors] doubleDescriptor];
}

+ (id<PDPrimitiveDescriptor>)stringDescriptor {
    return [[self sharedDescriptors] stringDescriptor];
}

+ (id<PDDescriptor>)listDescriptor:(id<PDDescriptor>)elementDescriptor {
    return [[PDListDescriptor alloc] initWithElementDescriptor:elementDescriptor];
}

+ (id<PDDescriptor>)setDescriptor:(id<PDDescriptor>)elementDescriptor {
    return [[PDSetDescriptor alloc] initWithElementDescriptor:elementDescriptor];
}

+ (id<PDDescriptor>)mapDescriptorWithKeyDescriptor:(id<PDDescriptor>)keyDescriptor
                                   valueDescriptor:(id<PDDescriptor>)valueDescriptor
{
    return [[PDMapDescriptor alloc] initWithKeyDescriptor:keyDescriptor
                                          valueDescriptor:valueDescriptor];
}

+ (id<PDDescriptor>)voidDescriptor {
    return [[self sharedDescriptors] voidDescriptor];
}

@end
