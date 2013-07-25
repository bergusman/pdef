//
//  PDDoublePrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDDoublePrimitiveDescriptor.h"

@implementation PDDoublePrimitiveDescriptor

- (NSNumber *)default {
    return @((double)0);
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object doubleValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object doubleValue]);
    }
    return @((double)0);
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
