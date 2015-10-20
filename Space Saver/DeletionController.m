//
//  DeletionController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/19/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "DeletionController.h"

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
@end
