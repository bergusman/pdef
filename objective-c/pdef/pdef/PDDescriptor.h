//
//  PDDescriptor.h
//  pdef
//
//  Created by Vitaly Berg on 7/22/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Data type descriptor. */
@protocol PDDescriptor <NSObject>

/** Returns the default value for this data type. */
- (id)default;

/** Parses a data type from an object. */
- (id)parse:(id)object;

/** Serializes a data type into an object. */
- (id)serialize:(id)object;

@end
