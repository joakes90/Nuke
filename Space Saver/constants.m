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
 NSString *const kUserPrefs = @"userPrefs";

+ (instancetype) sharedInstance {
    static constants *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[constants alloc] init];
        sharedInstance.kUserPrefsPath = [@"~/Library/Preferences/" stringByExpandingTildeInPath];
    });
    return sharedInstance;
}

@end
