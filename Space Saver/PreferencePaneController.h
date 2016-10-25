//
//  PreferencePaneController.h
//  Nuke
//
//  Created by Justin Oakes on 10/20/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Application.h"

@interface PreferencePaneController : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<Application *> *prefs;

@property (assign, nonatomic, readonly) BOOL refreshingPrefs;

+ (instancetype) sharedInstance;

- (void) findAllPrefs;
- (Application *) appWithBundelID:(NSString *)bundelID;

@end
