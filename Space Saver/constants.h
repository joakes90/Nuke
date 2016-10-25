//
//  constants.h
//  Space Saver
//
//  Created by Justin Oakes on 9/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface constants : NSObject

//identifiers
extern NSString *const kUpdatedAppsArrayNotification;
extern NSString *const kFileRemovedNotification;
extern NSString *const kUninstallComplete;
extern NSString *const kDeleteMode;
extern NSString *const kResetMode;
extern NSString *const kpackageMode;
extern NSString *const kcellIdentString;
extern NSString *const kverifyDeletionSegue;
extern NSString *const kmainStoryBoard;
extern NSString *const kmainViewController;
extern NSString *const kappRunningSegue;
extern NSString *const kUserPrefs;
extern NSString *const kUserCaches;
extern NSString *const kUserAppSupport;
extern NSString *const kUserAutosave;
extern NSString *const kMisc;
extern NSString *const kContainers;
extern NSString *const kSaveState;
extern NSString *const kRootPrefs;
extern NSString *const kAppFolder;

//paths
@property (strong, nonatomic) NSString *kUserPrefsPath;
@property (strong, nonatomic) NSString *kUserCachesPath;
@property (strong, nonatomic) NSString *kUserAppSupportPath;
@property (strong, nonatomic) NSString *KUserAutoSavePath;
@property (strong, nonatomic) NSString *kMiscPath;
@property (strong, nonatomic) NSString *kContainersPath;
@property (strong, nonatomic) NSString *kSaveStatePath;
@property (strong, nonatomic) NSString *kRootPrefsPath;
@property (strong, nonatomic) NSString *kUserPrefPanes;
@property (strong, nonatomic) NSString *kPrefPanes;

//label text
extern NSString *const kinstalledPackages;
extern NSString *const kinstalledApps;
extern NSString *const kremoveApps;
extern NSString *const kresetApps;

//image names
extern NSString *const ktrashgrey;
extern NSString *const kresetgrey;
extern NSString *const kappIcon;
extern NSString *const ktrash;
extern NSString *const kreset;
extern NSString *const kpackageIcon;
extern NSString *const kcacheicon;
extern NSString *const kprefs;
extern NSString *const kappSupport;
extern NSString *const kcontainer;
extern NSString *const ksaveStateImage;

// animation names
extern NSString *const kslideIn;
extern NSString *const kslideOut;
extern NSString *const kslide;

// componet types
extern NSString *const kUserPrefrences;
extern NSString *const kCache;
extern NSString *const kApplicationSupport;
extern NSString *const kAutoSaves;
extern NSString *const kContainer;
extern NSString *const kSaveStates;
extern NSString *const kRootPrefrences;
extern NSString *const kmisc;

+ (instancetype) sharedInstance;

@end
