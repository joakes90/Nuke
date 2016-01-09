//
//  RegistrationViewController.m
//  Nuke
//
//  Created by Justin Oakes on 1/6/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AutherizationController.h"
#import "ThanksViewController.h"

@interface RegistrationViewController () <NSTextFieldDelegate>

@property (strong) IBOutlet NSTextField *emailTextField;
@property (strong) IBOutlet NSTextField *serialTextField;
@property (strong) IBOutlet NSTextField *welcomeLabel;
@property (strong) IBOutlet NSButton *tryButton;
@property (strong) IBOutlet NSButton *registerButton;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.emailTextField.delegate = self;
    self.serialTextField.delegate = self;
}

-(void)viewDidAppear {
    AutherizationController *auth = [[AutherizationController alloc] init];
    if ([auth trialHasExpired]) {
        [self.tryButton setEnabled:NO];
    }
    
    NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString *serial = [[NSUserDefaults standardUserDefaults] stringForKey:@"serial"];
    
    [self.emailTextField setStringValue:email ? email : @""];
    [self.serialTextField setStringValue:serial ? [serial uppercaseString] : @""];
}

- (IBAction)startTrial:(id)sender {
    [AutherizationController startTrial];
    [self.view.window close];
}

#pragma mark Textfield Delegate Methods

-(void)controlTextDidChange:(NSNotification *)obj {
    if ([obj.object isEqual:self.emailTextField]) {
        [self manageEmailTextField];
    } else if ([obj.object isEqual:self.serialTextField]) {
        [self manageSerialTextField];
    }
}

- (void) manageEmailTextField {
    if ([self.emailTextField.stringValue containsString:@"@"] && [self.emailTextField.stringValue containsString:@"."]) {
        [self.serialTextField setEnabled:YES];
    } else {
        [self.serialTextField setEnabled:NO];
    }
}

- (void) manageSerialTextField {
    AutherizationController *auth = [[AutherizationController alloc] init];
    switch ([self.serialTextField.stringValue length]) {
        case 5:
            if ([self.serialTextField currentEditor].selectedRange.location == 5) {
                [self.serialTextField setStringValue:[[self.serialTextField.stringValue stringByAppendingString:@"-"] uppercaseString]];
            }
            break;
        case 11:
            if ([self.serialTextField currentEditor].selectedRange.location == 11) {
                [self.serialTextField setStringValue:[[self.serialTextField.stringValue stringByAppendingString:@"-"] uppercaseString]];
            }
            break;
        case 17:
            if ([self.serialTextField currentEditor].selectedRange.location == 17) {
                [self.serialTextField setStringValue:[[self.serialTextField.stringValue stringByAppendingString:@"-"] uppercaseString]];
            }
            break;
        case 23:
            if ([self.serialTextField currentEditor].selectedRange.location == 23) {
                [self.serialTextField setStringValue:[[self.serialTextField.stringValue stringByAppendingString:@"-"] uppercaseString]];
            }
            break;
        case 29:
            if ([auth validateWithEmail:self.emailTextField.stringValue andSerial:self.serialTextField.stringValue]) {
                [self.registerButton setEnabled:YES];
            } else {
                [self.registerButton setEnabled:NO];
            }
            break;
        case 30:
            [self.serialTextField setStringValue:[[self.serialTextField.stringValue substringToIndex:29] uppercaseString]];
            break;
        default:
            [self.serialTextField setStringValue:[self.serialTextField.stringValue uppercaseString]];
            [self.registerButton setEnabled:NO];
            break;
    }
}

- (IBAction)register:(id)sender {
    [[NSUserDefaults standardUserDefaults] setValue:self.emailTextField.stringValue forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.serialTextField.stringValue forKey:@"serial"];
    [self performSegueWithIdentifier:@"thanks" sender:nil];
    [self.view.window close];
}

- (IBAction)openPurachePage:(id)sender {
    NSURL *purchaseURL = [NSURL URLWithString:@"https://oklasoftware.com/nuke/buy.html"];
    [[NSWorkspace sharedWorkspace] openURL:purchaseURL];
}

@end
