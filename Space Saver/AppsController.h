//
//  AppsController.h
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Application.h"

@interface AppsController : NSObject

@property (strong, nonatomic, readonly) NSMutableArray<Application *> *apps;

@property (assign, nonatomic, readonly) BOOL refreshingApps;

@property (assign, nonatomic) BOOL enabled;

+ (instancetype) sharedInstance;

- (void) findAllApplications;

- (Application *) appWithBundelID:(NSString *)bundelID;

- (NSArray *)applicationsWithTerm:(NSString *)term;

@end
