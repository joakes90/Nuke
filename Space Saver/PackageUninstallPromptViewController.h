//
//  PackageUninstallPromptViewController.h
//  Space Saver
//
//  Created by Justin Oakes on 12/5/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Package.h"

@interface PackageUninstallPromptViewController : NSViewController

@property (strong, nonatomic) Package *package;
    
@end
