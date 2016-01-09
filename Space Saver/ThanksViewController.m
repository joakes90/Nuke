//
//  ThanksViewController.m
//  Nuke
//
//  Created by Justin Oakes on 1/9/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "ThanksViewController.h"

@interface ThanksViewController ()

@end

@implementation ThanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(void)viewWillAppear {
    [self.view.window setStyleMask:[self.view.window styleMask] & ~NSResizableWindowMask];
}

- (IBAction)close:(id)sender {
    [self.view.window close];
}

@end
