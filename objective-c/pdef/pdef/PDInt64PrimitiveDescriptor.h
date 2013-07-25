//
//  PDInt64PrimitiveDescriptor.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDPrimitiveDescriptor.h"

@interface PDInt64PrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

- (NSNumber *)default;
- (NSNumber *)parse:(id)object;
- (NSNumber *)serialize:(NSNumber *)object;
- (NSNumber *)parseFromString:(NSString *)string;
- (NSString *)serializeToString:(NSNumber *)object;

@end
