package io.pdef;

import java.util.EnumSet;

/** Pdef types. */
public enum PdefType {
	INTERFACE, FUTURE, VOID,
	MESSAGE, OBJECT, LIST, SET, MAP, ENUM,
	BOOL, INT16, INT32, INT64, FLOAT, DOUBLE, DECIMAL, DATE, DATETIME, STRING, UUID;

	private static final EnumSet<PdefType> PRIMITIVES;
	private static final EnumSet<PdefType> DATATYPES;

	static {
		PRIMITIVES = EnumSet.of(BOOL, INT16, INT32, INT64, FLOAT, DOUBLE, DECIMAL,
				DATE, DATETIME, STRING, UUID);

		DATATYPES = EnumSet.of(MESSAGE, OBJECT, LIST, SET, MAP, ENUM);
		DATATYPES.addAll(PRIMITIVES);
	}

	public boolean isInterface() {
		return this == INTERFACE;
	}

	public boolean isFuture() {
		return this == FUTURE;
	}

	public boolean isVoid() {
		return this == VOID;
	}

	public boolean isDatatype() {
		return DATATYPES.contains(this);
	}

	public boolean isPrimitive() {
		return PRIMITIVES.contains(this);
	}
}