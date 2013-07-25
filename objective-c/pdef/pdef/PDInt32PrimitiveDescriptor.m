//
//  PDInt32PrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDInt32PrimitiveDescriptor.h"

@implementation PDInt32PrimitiveDescriptor

- (NSNumber *)default {
    return @(0);
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object intValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object intValue]);
    }
    return @(0);
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @(object ? [object intValue] : 0);
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @(string ? [string intValue] : 0);
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@(object ? [object intValue] : 0) stringValue];
}

@end
