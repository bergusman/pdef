//
//  PDBoolPrimitiveDescriptor.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDBoolPrimitiveDescriptor.h"

@implementation PDBoolPrimitiveDescriptor

- (NSNumber *)default {
    return @NO;
}

- (NSNumber *)parse:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return @([object boolValue]);
    }
    if ([object isKindOfClass:[NSString class]]) {
        return @([object boolValue]);
    }
    return @(NO);
}

- (NSNumber *)serialize:(NSNumber *)object {
    return @(object ? [object boolValue] : NO);
}

- (NSNumber *)parseFromString:(NSString *)string {
    return @(string ? [string boolValue] : NO);
}

- (NSString *)serializeToString:(NSNumber *)object {
    return [@(object ? [object boolValue] : NO) stringValue];
}

@end
