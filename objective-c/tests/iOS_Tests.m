//
//  iOS_Tests.m
//  iOS Tests
//
//  Created by Vitaly Berg on 8/4/13.
//
//

#import "iOS_Tests.h"

#import "PDDescriptors.h"
#import "PDException.h"

@implementation iOS_Tests

- (void)testBoolDescriptor {
    id<PDDescriptor> boolDescriptor = [PDDescriptors boolDescriptor];
    
    STAssertNotNil(boolDescriptor, nil);
    
    id outputValue;
    
    // Defalut
    outputValue = [boolDescriptor default];
    [self checkNumberValue:outputValue withOtherValue:@NO];
    
    // Parse
    outputValue = [boolDescriptor parse:@YES];
    [self checkNumberValue:outputValue withOtherValue:@YES];
    
    outputValue = [boolDescriptor parse:@1];
    [self checkNumberValue:outputValue withOtherValue:@YES];
    
    outputValue = [boolDescriptor parse:@"true"];
    [self checkNumberValue:outputValue withOtherValue:@YES];
    
    outputValue = [boolDescriptor parse:nil];
    [self checkNumberValue:outputValue withOtherValue:@NO];
    
    outputValue = [boolDescriptor parse:[NSNull null]];
    [self checkNumberValue:outputValue withOtherValue:@NO];
    
    STAssertThrowsSpecificNamed([boolDescriptor parse:@[]], NSException, PDCastException, nil);
}

- (void)checkNumberValue:(NSNumber *)value withOtherValue:(NSNumber *)otherValue {
    STAssertTrue([value isKindOfClass:[NSNumber class]], nil);
    STAssertEquals(strcmp([value objCType], [otherValue objCType]), 0, nil);
    STAssertEqualObjects(value, otherValue, nil);
}

@end
