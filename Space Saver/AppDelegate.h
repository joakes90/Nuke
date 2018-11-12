//
//  AppDelegate.h
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WindowController.h"
#import "AutherizationController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property WindowController *windowController;
//@property (strong, nonatomic) AutherizationController *authController;
@property (assign, nonatomic) BOOL askedForPassword;

@end

