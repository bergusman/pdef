//
//  PDAppDelegate.h
//  pdef
//
//  Created by Vitaly Berg on 7/25/13.
//  Copyright (c) 2013 Vitaly Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDViewController;

@interface PDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PDViewController *viewController;

@end
