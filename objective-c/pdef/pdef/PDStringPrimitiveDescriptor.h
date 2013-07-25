//
//  PDStringPrimitiveDescriptor.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDPrimitiveDescriptor.h"

@interface PDStringPrimitiveDescriptor : NSObject <PDPrimitiveDescriptor>

- (NSString *)default;
- (NSString *)parse:(id)object;
- (NSString *)serialize:(NSNumber *)object;
- (NSString *)parseFromString:(NSString *)string;
- (NSString *)serializeToString:(NSNumber *)object;

@end
