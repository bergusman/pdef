//
//  PDFloatPrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDFloatPrimitiveDescriptor.h"

@implementation PDFloatPrimitiveDescriptor

- (NSNumber *)default {
    return @((float)0);
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object floatValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object floatValue]);
    }
    return @((float)0);
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @((float)(object ? [object floatValue] : 0));
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @((float)(string ? [string floatValue] : 0));
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@((float)(object ? [object floatValue] : 0)) stringValue];
}

@end
