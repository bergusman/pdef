//
//  PDDescriptors.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDPrimitiveDescriptor.h"

@interface PDDescriptors : NSObject

+ (id<PDPrimitiveDescriptor>)boolDescriptor;
+ (id<PDPrimitiveDescriptor>)int16Descriptor;
+ (id<PDPrimitiveDescriptor>)int32Descriptor;
+ (id<PDPrimitiveDescriptor>)int64Descriptor;

+ (id<PDPrimitiveDescriptor>)floatDescriptor;
+ (id<PDPrimitiveDescriptor>)doubleDescriptor;

+ (id<PDPrimitiveDescriptor>)stringDescriptor;

+ (id<PDDescriptor>)listDescriptor;
+ (id<PDDescriptor>)setDescriptor;
+ (id<PDDescriptor>)mapDescriptor;

+ (id<PDDescriptor>)voidDescriptor;

@end


