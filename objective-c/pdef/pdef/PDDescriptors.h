//
//  PDDescriptors.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDBoolPrimitiveDescriptor.h"

@interface PDDescriptors : NSObject

+ (PDBoolPrimitiveDescriptor *)boolDescriptor;
+ (PDBoolPrimitiveDescriptor *)int16Descriptor;
+ (PDBoolPrimitiveDescriptor *)int32Descriptor;
+ (PDBoolPrimitiveDescriptor *)int64Descriptor;

+ (PDBoolPrimitiveDescriptor *)floatDescriptor;
+ (PDBoolPrimitiveDescriptor *)doubleDescriptor;

+ (PDBoolPrimitiveDescriptor *)listDescriptor;
+ (PDBoolPrimitiveDescriptor *)setDescriptor;
+ (PDBoolPrimitiveDescriptor *)mapDescriptor;

@end
