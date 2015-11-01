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
