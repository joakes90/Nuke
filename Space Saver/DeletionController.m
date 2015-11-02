//
//  DeletionController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/19/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "DeletionController.h"
#import "constants.h"

@implementation DeletionController

- (BOOL)appIsRunning:(Application *)app {
    BOOL appIsRunning = NO;
    NSArray *runningApplications = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *runningApplication in runningApplications) {
        if ([runningApplication.bundleIdentifier isEqualToString:app.bundelIdentifier]) {
            appIsRunning = YES;
        }
    }
    return appIsRunning;
}

- (BOOL) appAppearsInDock:(Application *)app {
    BOOL inDock = NO;
    NSMutableArray *dockDict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.apple.dock"][@"persistent-apps"];
    for (NSDictionary * entery in dockDict) {
        if ([entery[@"tile-data"][@"bundle-identifier"] isEqualToString:app.bundelIdentifier]){
            inDock = YES;
        }
    }
    return inDock;
}

- (void) removeFromDockApplicationWithBundelIdentifier:(NSString *)ident {
    NSMutableDictionary *dockDict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.apple.dock"]];
    NSMutableArray *dockArray = dockDict[@"persistent-apps"];
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < dockArray.count; i++) {
        if (![dockArray[i][@"tile-data"][@"bundle-identifier"] isEqualToString:ident]) {
            [newArray addObject:dockArray[i]];
        }
    }
    dockDict[@"persistent-apps"] = newArray;
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:dockDict forName:@"com.apple.dock"];
    [NSUserDefaults resetStandardUserDefaults];
    NSAppleScript *restartDock = [[NSAppleScript alloc] initWithSource:@"tell application \"Dock\" to quit"];
    [restartDock executeAndReturnError:nil];
}

- (void) removeComponetFromMac:(NSDictionary *)componets {
    NSString *key = [componets allKeys][0];
    NSString *path;
    if ([key isEqualToString:kUserPrefs]) {
        path = [[constants sharedInstance].kUserPrefsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kUserCaches]) {
        path = [[constants sharedInstance].kUserCachesPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kUserAppSupport]) {
        path = [[constants sharedInstance].kUserAppSupportPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kUserAutosave]) {
        path = [[constants sharedInstance].KUserAutoSavePath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kMisc]) {
        path = [[constants sharedInstance].kMiscPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kContainers]) {
        path = [[constants sharedInstance].kContainersPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kSaveState]) {
        path = [[constants sharedInstance].kSaveStatePath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kRootPrefs]) {
        path = [[constants sharedInstance].kRootPrefsPath stringByAppendingString:[NSString stringWithFormat:@"/%@", componets[key]]];
    }
    if ([key isEqualToString:kAppFolder]) {
        path = componets[key];
    }
    if (path) {
        [[NSFileManager defaultManager] trashItemAtURL:[[NSURL alloc] initFileURLWithPath:path] resultingItemURL:nil error:nil];
    }
}

- (void) removeApplicationFromMac:(NSString *)name; {
    [[NSFileManager defaultManager] trashItemAtURL:[[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"/Applications/%@", name]]
                                  resultingItemURL:nil
                                             error:nil];
}
@end
