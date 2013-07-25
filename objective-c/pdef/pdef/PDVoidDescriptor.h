//
//  PDVoidPrimitiveDescriptor.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDDescriptor.h"

@interface PDVoidDescriptor : NSObject <PDDescriptor>

- (NSNumber *)default;
- (NSNumber *)parse:(id)object;
- (NSNumber *)serialize:(NSNumber *)object;

@end
