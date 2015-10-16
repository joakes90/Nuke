//
//  Application.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "Application.h"
#import "constants.h"

@implementation Application

+ (id) applicationWithName:(NSString *)name Path:(NSString *)path BundelIdentifier:(NSString *)bundelIdentifier Andicon:(NSImage *)icon {
    Application *application = [[Application alloc] init];
    application.name = name;
    application.path = path;
    application.bundelIdentifier = bundelIdentifier;
    application.icon = icon;
    
    return application;
}

- (NSDictionary *) returnComponetsForApplication {
    NSMutableDictionary *components = [[NSMutableDictionary alloc] init];
    NSArray *userPrefs = [self findUserPrefsForApp];
    if (userPrefs.count > 0) {
        [components setObject:userPrefs forKey:kUserPrefs];
    }
    return components;
}

- (void) setComponetsForApplication {
    self.appComponets = [self returnComponetsForApplication];
}

//methods for finding componets

- (NSArray *)findUserPrefsForApp {
    NSMutableArray *foundPrefs = [[NSMutableArray alloc] init];
    
    NSArray *allUserPrefs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kUserPrefsPath error:nil];
    for (NSString *name in allUserPrefs) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundPrefs addObject:name];
        }
    }

    return foundPrefs;
}
@end
