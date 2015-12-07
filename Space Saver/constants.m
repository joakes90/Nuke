//
//  constants.m
//  Space Saver
//
//  Created by Justin Oakes on 9/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "constants.h"

@implementation constants

 NSString *const kUpdatedAppsArrayNotification = @"appsArrayUpdated";
 NSString *const kFileRemovedNotification = @"fileRemoved";
 NSString *const kUninstallComplete = @"uninstallComplete";
 NSString *const kDeleteMode = @"delete";
 NSString *const kResetMode = @"reset";
 NSString *const kpackageMode = @"package";

 NSString *const kUserPrefs = @"userPrefs";
 NSString *const kUserCaches = @"userCaches";
 NSString *const kUserAppSupport = @"userAppSupport";
 NSString *const kUserAutosave = @"userAutoSave";
 NSString *const kMisc = @"misc";
 NSString *const kContainers = @"container";
 NSString *const kUserLaunchAgents = @"userLaunchAgents";
 NSString *const kSaveState = @"saveStates";
 NSString *const kRootPrefs = @"rootPrefs";
 NSString *const kAppFolder = @"appFolder";

+ (instancetype) sharedInstance {
    static constants *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[constants alloc] init];
        sharedInstance.kUserPrefsPath = [@"~/Library/Preferences/" stringByExpandingTildeInPath];
        sharedInstance.kUserCachesPath = [@"~/Library/Caches/" stringByExpandingTildeInPath];
        sharedInstance.kUserAppSupportPath = [@"~/Library/Application Support" stringByExpandingTildeInPath];
        sharedInstance.KUserAutoSavePath = [@"~/Library/Autosave Information" stringByExpandingTildeInPath];
        sharedInstance.kMiscPath = [@"~/Library/" stringByExpandingTildeInPath];
        sharedInstance.kContainersPath = [@"~/Library/Containers" stringByExpandingTildeInPath];
        sharedInstance.kSaveStatePath = [@"~/Library/Saved Application State" stringByExpandingTildeInPath];
        sharedInstance.kRootPrefsPath = @"/Library/Preferences";
    });
    return sharedInstance;
}

@end
