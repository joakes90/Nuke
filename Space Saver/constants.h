//
//  constants.h
//  Space Saver
//
//  Created by Justin Oakes on 9/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface constants : NSObject

extern NSString *const kUpdatedAppsArrayNotification;
extern NSString *const kDeleteMode;
extern NSString *const kResetMode;

extern NSString *const kUserPrefs;
extern NSString *const kUserCaches;
extern NSString *const kUserAppSupport;
extern NSString *const kUserAutosave;
extern NSString *const kMisc;
extern NSString *const kContainers;
extern NSString *const kSaveState;
extern NSString *const kRootPrefs;
extern NSString *const kAppFolder;

@property (strong, nonatomic) NSString *kUserPrefsPath;
@property (strong, nonatomic) NSString *kUserCachesPath;
@property (strong, nonatomic) NSString *kUserAppSupportPath;
@property (strong, nonatomic) NSString *KUserAutoSavePath;
@property (strong, nonatomic) NSString *kMiscPath;
@property (strong, nonatomic) NSString *kContainersPath;
@property (strong, nonatomic) NSString *kSaveStatePath;
@property (strong, nonatomic) NSString *kRootPrefsPath;

+ (instancetype) sharedInstance;

@end
