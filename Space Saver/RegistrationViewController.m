//
//  RegistrationViewController.m
//  Nuke
//
//  Created by Justin Oakes on 1/6/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AutherizationController.h"

@interface RegistrationViewController () <NSTextFieldDelegate>

@property (strong) IBOutlet NSTextField *emailTextField;
@property (strong) IBOutlet NSTextField *serialTextField;
@property (strong) IBOutlet NSTextField *welcomeLabel;
@property (strong) IBOutlet NSButton *tryButton;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.emailTextField.delegate = self;
}

- (IBAction)startTrial:(id)sender {
    [AutherizationController startTrial];
    [self.view.window close];
}

#pragma mark Textfield Delegate Methods

-(void)controlTextDidChange:(NSNotification *)obj {
    NSLog(@"%@", obj);
}

@end
