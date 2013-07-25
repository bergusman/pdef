//
//  PDVoid.m
//  pdef
//
//  Created by Vitaly Berg on 25.07.13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import "PDVoid.h"

static PDVoid *_void;

@implementation PDVoid

- (id)init {
    if (_void) {
        return _void;
    }
    
    self = [super init];
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [PDVoid void];
}

+ (PDVoid *)void {
    if (!_void) {
        _void = [[PDVoid alloc] init];
    }
    return _void;
}

@end
