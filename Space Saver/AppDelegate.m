//
//  AppDelegate.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppDelegate.h"
#import "AppsController.h"
#import "PreferencePaneController.h"
#import "MainViewController.h"
#import "constants.h"

#include <ServiceManagement/ServiceManagement.h>
#include <Security/Security.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSError *error;
    if (![self blessHelperWithLabel:kJobBlessLabel error:&error]) {
        NSLog(@"Failed to bless job with error %@", error);
        return;
    }
    NSLog(@"Blessing worked?");
    // Connect to helper tool

    // Find applications
    [AppsController sharedInstance];
    [PreferencePaneController sharedInstance];
}

- (BOOL) blessHelperWithLabel:(NSString *)label error:(NSError **)error {
    BOOL result = NO;

    AuthorizationItem authItem = { kSMRightBlessPrivilegedHelper, 0, NULL, 0};
    AuthorizationRights authRights = {1, &authItem};
    AuthorizationFlags flags = kAuthorizationFlagDefaults |
                               kAuthorizationFlagInteractionAllowed |
                               kAuthorizationFlagPreAuthorize |
                               kAuthorizationFlagExtendRights;
    AuthorizationRef authRef = NULL;

    OSStatus status = AuthorizationCreate(&authRights, kAuthorizationEmptyEnvironment, flags, &authRef);
    if (status != errAuthorizationSuccess) {
        NSLog(@"Failed to authorize with status %d", (int)status);
    } else {
        result = SMJobBless(kSMDomainSystemLaunchd, (__bridge CFStringRef)label, authRef, (void *)error);
    }
    return result;
}

-(void)applicationDidBecomeActive:(NSNotification *)notification {
//    self.xpcConnection = [[NSXPCConnection alloc] initWithServiceName:@"com.justin.NukeHelper"];
//    self.xpcConnection.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(NukeHelperProtocol)];
//    [self.xpcConnection resume];
//    [[self.xpcConnection remoteObjectProxy] trashFile:nil withReply:^(NSString *reply) {
//        NSLog(@"Hello, %@", reply);
//    }];

//    self.authController = [[AutherizationController alloc] init];

//    if ([self.authController appIsRegistered]) {
//        //actions to perform when serial is found valid
//    } else {
        MainViewController *mainView = (MainViewController *)[[[NSApplication sharedApplication] mainWindow] contentViewController];
        [mainView performSegueWithIdentifier:@"register" sender:self.windowController];
//    }
}

- (IBAction)refreshApps:(id)sender {
    [[AppsController sharedInstance] findAllApplications];
    [[PreferencePaneController sharedInstance] findAllPrefs];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (flag) {
        return NO;
    } else {
        NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        windowController = [sb instantiateControllerWithIdentifier:@"window"];
        [windowController showWindow:self];
//        if (![self.authController appIsRegistered]) {
            [windowController.contentViewController performSegueWithIdentifier:@"register" sender:self.windowController];
//        }
        return YES;
    }
}

- (IBAction)register:(id)sender {
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSWindowController *newWindow = [sb instantiateControllerWithIdentifier:@"registerNonmodal"];
    [newWindow showWindow:self];
}

- (IBAction)recoverSN:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://oklasoftware.com/recovery.html"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

@end
