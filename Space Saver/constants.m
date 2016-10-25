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
 NSString *const kappRunningSegue = @"appRunning";
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
NSString *const kremoveApps = @"Remove App";
NSString *const kresetApps = @"Rest App";

//image names
NSString *const ktrashgrey = @"trashgrey";
NSString *const kresetgrey = @"resetgrey";
NSString *const kappIcon = @"appicon";
NSString *const ktrash = @"trash";
NSString *const kreset = @"reset";
NSString *const kpackageIcon = @"packageicon";
NSString *const kcacheicon = @"cacheicon";
NSString *const kprefs = @"prefs";
NSString *const kappSupport = @"appSupport";

// animation names
NSString *const kslideIn = @"slideIn";
NSString *const kslideOut = @"slideOut";
NSString *const kslide = @"slide";

// componet types
NSString *const kUserPrefrences = @"User Prefrences";
NSString *const kCache = @"Cache";
NSString *const kApplicationSupport = @"Application Support";
NSString *const kAutoSaves = @"Auto Saves";
NSString *const kContainer = @"Container";
NSString *const kSaveStates = @"Save State";
NSString *const kRootPrefrences = @"Root Prefrences";
NSString *const kmisc = @"Misc";
NSString *const kcontainer = @"container";
NSString *const ksaveStateImage = @"saveState";

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
        sharedInstance.kUserPrefPanes = [@"~/Library/PreferencePanes" stringByExpandingTildeInPath];
        sharedInstance.kPrefPanes = @"/Library/PreferencePanes";
    });
    return sharedInstance;
}

@end
