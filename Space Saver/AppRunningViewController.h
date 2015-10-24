//
//  AppRunningViewController.h
//  Space Saver
//
//  Created by Justin Oakes on 10/24/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Application.h"

@interface AppRunningViewController : NSViewController

@property (strong) IBOutlet NSTextField *messageLabel;

@property (strong) IBOutlet NSImageView *appImage;

@property (strong, nonatomic) Application *app;

@end
