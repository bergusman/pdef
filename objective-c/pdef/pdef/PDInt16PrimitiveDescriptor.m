//
//  PDInt16PrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDInt16PrimitiveDescriptor.h"

@implementation PDInt16PrimitiveDescriptor

- (NSNumber *)default {
    return @((short)0);
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object shortValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object intValue]);
    }
    return @((short)0);
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @((short)(object ? [object shortValue] : 0));
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @((short)(string ? [string intValue] : 0));
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@((short)(object ? [object shortValue] : 0)) stringValue];
}

@end
