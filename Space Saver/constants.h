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
extern NSString *const kUserPrefs;

@property (strong, nonatomic) NSString *kUserPrefsPath;

+ (instancetype) sharedInstance;

@end
