//
//  AppRunningViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/24/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppRunningViewController.h"

@interface AppRunningViewController ()

@end

@implementation AppRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)viewDidAppear {
    self.messageLabel.stringValue = [NSString stringWithFormat:@"Application %@ is already running. Please stop this process before trying to uninstall", [self.app.name stringByReplacingOccurrencesOfString:@".app" withString:@""]];
    self.appImage.image = self.app.icon;
}

- (IBAction)ok:(id)sender {
    [self dismissViewController:self];
}

@end
