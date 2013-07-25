//
//  PDInt64PrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDInt64PrimitiveDescriptor.h"

@implementation PDInt64PrimitiveDescriptor

- (NSNumber *)default {
    return @((long long)0);
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object longLongValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object longLongValue]);
    }
    return @((long long)0);
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @((long long)(object ? [object longLongValue] : 0));
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @((long long)(string ? [string longLongValue] : 0));
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@((long long)(object ? [object longLongValue] : 0)) stringValue];
}

@end
