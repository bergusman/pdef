package pdef;

import java.util.Map;

public interface Message extends Type {

	@Override
	MessageDescriptor getDescriptor();

	Builder newBuilderForType();

	Builder toBuilder();

	@Override
	Map<String, Object> serialize();

	interface Builder {
		MessageDescriptor getDescriptor();

		Message build();
	}
}
