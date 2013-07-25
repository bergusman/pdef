//
//  PDPrimitiveDescriptor.h
//  pdef
//
//  Created by Vitaly Berg on 7/22/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDDescriptor.h"

@protocol PDPrimitiveDescriptor <PDDescriptor>

/** Parses a primitive from a string. */
- (id)parseFromString:(NSString *)string;

/** Serializes a primitive to a string. */
- (NSString *)serializeToString:(id)object;

@end
