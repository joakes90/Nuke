//
//  constants.m
//  Space Saver
//
//  Created by Justin Oakes on 9/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "constants.h"

@implementation constants

//identifiers
 NSString *const kUpdatedAppsArrayNotification = @"appsArrayUpdated";
 NSString *const kFileRemovedNotification = @"fileRemoved";
 NSString *const kUninstallComplete = @"uninstallComplete";
 NSString *const kDeleteMode = @"delete";
 NSString *const kResetMode = @"reset";
 NSString *const kpackageMode = @"package";
 NSString *const kcellIdentString = @"cell";
 NSString *const kverifyDeletionSegue = @"verifyDeletion";
 NSString *const kmainStoryBoard = @"Main";
 NSString *const kmainViewController = @"main";

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

//label text
NSString *const kinstalledPackages = @"Installed Packages";
NSString *const kinstalledApps = @"Installed Apps";

//image names
NSString *const ktrashgrey = @"trashgrey";
NSString *const kresetgrey = @"resetgrey";
NSString *const kappIcon = @"appicon";
NSString *const ktrash = @"trash";
NSString *const kreset = @"reset";
NSString *const kpackageIcon = @"packageicon";

// animation names
NSString *const kslideIn = @"slideIn";
NSString *const kslideOut = @"slideOut";

//paths
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
