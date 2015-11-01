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
    NSArray *userCaches = [self findUserCachesForApp];
    NSArray *userAppSupport = [self findUserApplicationSupport];
    NSArray *userAutoSave = [self findUserAutoSave];
    NSArray *libDirectories = [self findUserLibraryDirectories];
    NSArray *containers = [self findContainers];
    NSArray *saveStates = [self findSaveStates];
//    NSArray *rootPrefs = [self findRootPrefs];
    
    if (userPrefs.count > 0) {
        [components setObject:userPrefs forKey:kUserPrefs];
    }
    if (userCaches.count > 0) {
        [components setObject:userCaches forKey:kUserCaches];
    }
    if (userAppSupport.count > 0) {
        [components setObject:userAppSupport forKey:kUserAppSupport];
    }
    if (userAutoSave.count > 0) {
        [components setObject:userAutoSave forKey:kUserAutosave];
    }
    if (libDirectories.count > 0) {
        [components setObject:libDirectories forKey:kMisc];
    }
    if (containers.count > 0) {
        [components setObject:containers forKey:kContainers];
    }
    if (saveStates.count > 0) {
        [components setObject:saveStates forKey:kSaveState];
    }
//    if (rootPrefs.count > 0) {
//        [components setObject:rootPrefs forKey:kRootPrefs];
//    }
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

- (NSArray *)findUserCachesForApp {
    NSMutableArray *foundCaches = [[NSMutableArray alloc] init];
    
    NSArray *allCaches = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kUserCachesPath error:nil];
    for (NSString *name in allCaches) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundCaches addObject:name];
        }
    }
    return foundCaches;
}

- (NSArray *)findUserApplicationSupport {
    NSMutableArray *foundSupport = [[NSMutableArray alloc] init];
    
    NSArray *allSupport = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kUserAppSupportPath error:nil];
    for (NSString *name in allSupport) {
        if ([name containsString:[self.name stringByReplacingOccurrencesOfString:@".app" withString:@""]] || [name containsString:[[self.name stringByReplacingOccurrencesOfString:@".app" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
            [foundSupport addObject:name];
        }
    }
    return foundSupport;
}

- (NSArray *)findUserAutoSave {
    NSMutableArray *foundAutoSave = [[NSMutableArray alloc] init];
    
    NSArray *allAutoSaves = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].KUserAutoSavePath error:nil];
    for (NSString *name in allAutoSaves) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundAutoSave addObject:name];
        }
    }
    return foundAutoSave;
}

- (NSArray *)findUserLibraryDirectories{
    NSMutableArray *foundDir = [[NSMutableArray alloc] init];
    
    NSArray *allDirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kMiscPath error:nil];
    for (NSString *name in allDirs) {
        if ([name isEqualToString:[self.name stringByReplacingOccurrencesOfString:@".app" withString:@""]] || [name isEqualToString:[[self.name stringByReplacingOccurrencesOfString:@".app" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
            [foundDir addObject:name];
        }
    }
    return foundDir;
}

- (NSArray *)findContainers {
    NSMutableArray *foundContainer = [[NSMutableArray alloc] init];
    
    NSArray *allContainers = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kContainersPath error:nil];
    for (NSString *name in allContainers) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundContainer addObject:name];
        }
    }
    return foundContainer;
}

- (NSArray *)findSaveStates {
    NSMutableArray *foundStates = [[NSMutableArray alloc] init];
    
    NSArray *allStates = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kSaveStatePath error:nil];
    for (NSString *name in allStates) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundStates addObject:name];
        }
    }
    return foundStates;
}

- (NSArray *)findRootPrefs {
    NSMutableArray *foundPrefs = [[NSMutableArray alloc] init];
    
    NSArray *allPrefs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kRootPrefsPath error:nil];
    for (NSString *name in allPrefs) {
        if ([name containsString:self.bundelIdentifier]) {
            [foundPrefs addObject:name];
        }
    }
    return foundPrefs;
}
@end
