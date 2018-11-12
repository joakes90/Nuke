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

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize windowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [AppsController sharedInstance];
    [PreferencePaneController sharedInstance];
}

-(void)applicationDidBecomeActive:(NSNotification *)notification {
    self.askedForPassword = [[NSUserDefaults standardUserDefaults] boolForKey:kAskedForPassword];
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
