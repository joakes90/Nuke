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

//label text
extern NSString *const kinstalledPackages;
extern NSString *const kinstalledApps;

//image names
extern NSString *const ktrashgrey;
extern NSString *const kresetgrey;
extern NSString *const kappIcon;
extern NSString *const ktrash;
extern NSString *const kreset;
extern NSString *const kpackageIcon;

// animation names
extern NSString *const kslideIn;
extern NSString *const kslideOut;

+ (instancetype) sharedInstance;

@end
