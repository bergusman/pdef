//
//  PDDescriptors.m
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDDescriptors.h"

#pragma mark - Descriptors

@interface PDDescriptors ()

@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> boolDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int16Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int32Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> int64Descriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> floatDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> doubleDescriptor;
@property (strong, nonatomic, readonly) id<PDPrimitiveDescriptor> stringDescriptor;
@property (strong, nonatomic, readonly) id<PDDescriptor> listDescriptor;
@property (strong, nonatomic, readonly) id<PDDescriptor> setDescriptor;
@property (strong, nonatomic, readonly) id<PDDescriptor> mapDescriptor;
@property (strong, nonatomic, readonly) id<PDDescriptor> voidDescriptor;

+ (PDDescriptors *)sharedDescriptors;

@end

@implementation PDDescriptors

- (id)init {
    self = [super init];
    if (self) {
        _setDescriptor = [[PDSetPrimitiveDescriptor alloc] init];
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

+ (id<PDDescriptor>)listDescriptor {
    return [[self sharedDescriptors] listDescriptor];
}

+ (id<PDDescriptor>)setDescriptor {
    return [[self sharedDescriptors] setDescriptor];
}

+ (id<PDDescriptor>)mapDescriptor {
    return [[self sharedDescriptors] mapDescriptor];
}

+ (id<PDDescriptor>)voidDescriptor {
    return [[self sharedDescriptors] voidDescriptor];
}

@end

#pragma mark - Bool Descriptor

@interface PDBoolPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - Int16 Descriptor

@interface PDInt16PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - Int32 Descriptor

@interface PDInt32PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - Int64 Descriptor

@interface PDInt64PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - Float Descriptor

@interface PDFloatPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - Double Descriptor

@interface PDDoublePrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

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

#pragma mark - String Descriptor

@interface PDStringPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

@end

@implementation PDStringPrimitiveDescriptor

- (NSNumber *)default {
    return nil;
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

#pragma mark - List Descriptor

@interface PDListPrimitiveDescriptor : NSObject <PDDescriptor>

@end

@implementation PDListDescriptor

@end

#pragma mark - Set Descriptor

@interface PDSetPrimitiveDescriptor : NSObject <PDDescriptor>

@end

#pragma mark - Map Descriptor

@interface PDMapPrimitiveDescriptor : NSObject <PDDescriptor>

@end

@implementation PDMapDescriptor

@end

#pragma mark - Void Descriptor

@interface PDVoidDescriptor : NSObject <PDDescriptor>

@end

@implementation PDVoidDescriptor

@end
