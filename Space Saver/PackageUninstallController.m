//
//  PackageUninstallController.m
//  Space Saver
//
//  Created by Justin Oakes on 11/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "PackageUninstallController.h"
#import "DeletionController.h"
#import "AppsController.h"
#import "Application.h"
#import "AppRunningViewController.h"
#import "constants.h"
#import <Cocoa/Cocoa.h>

@implementation PackageUninstallController


+ (instancetype) sharedInstance {
    static PackageUninstallController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PackageUninstallController alloc] init];
        NSDictionary *packagesDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"packages" ofType:@"plist"]];
        NSArray *keys = [packagesDictionary allKeys];
        sharedInstance.packages = [[NSMutableArray alloc] init];
        for (NSString *key in keys) {
            Package *newPack = [[Package alloc] initFromDictionary:packagesDictionary[key]];
            [sharedInstance.packages addObject:newPack];
        }
    });
    return sharedInstance;
}

- (NSArray *) installedPackages {
    NSMutableArray *installedPackages = [[NSMutableArray alloc] init];
    for (Package *pack in self.packages) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:pack.idFile]) {
            [installedPackages addObject:pack];
        }
    }
    return installedPackages;
}

- (void) uninstallPackage:(Package *)package {
    DeletionController *deleter = [[DeletionController alloc] init];
    NSArray *filesToRemove = package.files;
    NSArray *dockItems = package.dockItems;
    NSArray *installedApps = [self installedAppsForListOfBundelIds:dockItems];
    
    for (NSString *app in dockItems) {
        BOOL appIsRunning = [deleter appIsRunning:app];
        if (appIsRunning) {
            Application *runningApp = [[AppsController sharedInstance] appWithBundelID:app];
            NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
            AppRunningViewController *vc = [sb instantiateControllerWithIdentifier:@"openApp"];
            vc.app = runningApp;
            [vc presentViewControllerAsModalWindow:vc];
            return;
        }
    }
    for (NSString *file in filesToRemove) {
        NSDictionary *uniqueItem = @{@"Unique Items" : file};
        [deleter removeComponetFromMac:uniqueItem];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFileRemovedNotification object:nil];
    }
    for (Application *app in installedApps) {
        [deleter appIsStartupItem:[app.name stringByReplacingOccurrencesOfString:@".app" withString:@""]];
    }
    for (NSString *dockItem in dockItems) {
        [deleter removeFromDockApplicationWithBundelIdentifier:dockItem];
        [[NSNotificationCenter defaultCenter] postNotificationName:kFileRemovedNotification object:nil];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kUninstallComplete object:nil];
}

- (NSArray *)installedAppsForListOfBundelIds:(NSArray *)bundelIDs {
    NSMutableArray *installedApps = [[NSMutableArray alloc] init];
    for (NSString *ID in bundelIDs) {
        Application *app = [[AppsController sharedInstance] appWithBundelID:ID];
        if (app) {
            [installedApps addObject:app];
        }
    }
    return installedApps;
}
@end
