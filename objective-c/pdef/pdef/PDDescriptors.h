//
//  PDDescriptors.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDBoolPrimitiveDescriptor.h"
#import "PDInt16PrimitiveDescriptor.h"
#import "PDInt32PrimitiveDescriptor.h"
#import "PDInt64PrimitiveDescriptor.h"

#import "PDFloatPrimitiveDescriptor.h"
#import "PDDoublePrimitiveDescriptor.h"

#import "PDStringPrimitiveDescriptor.h"

#import "PDListDescriptor.h"
#import "PDSetDescriptor.h"
#import "PDMapDescriptor.h"

@interface PDDescriptors : NSObject

+ (PDBoolPrimitiveDescriptor *)boolDescriptor;
+ (PDBoolPrimitiveDescriptor *)int16Descriptor;
+ (PDBoolPrimitiveDescriptor *)int32Descriptor;
+ (PDBoolPrimitiveDescriptor *)int64Descriptor;

+ (PDBoolPrimitiveDescriptor *)floatDescriptor;
+ (PDBoolPrimitiveDescriptor *)doubleDescriptor;

+ (PDStringPrimitiveDescriptor *)stringDescriptor;

+ (PDBoolPrimitiveDescriptor *)listDescriptor;
+ (PDBoolPrimitiveDescriptor *)setDescriptor;
+ (PDBoolPrimitiveDescriptor *)mapDescriptor;

@end
