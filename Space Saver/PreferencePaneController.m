//
//  PreferencePaneController.m
//  Nuke
//
//  Created by Justin Oakes on 10/20/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "PreferencePaneController.h"
#import <Cocoa/Cocoa.h>
#import "constants.h"

@implementation PreferencePaneController

+ (instancetype) sharedInstance {
    static PreferencePaneController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PreferencePaneController alloc] init];
        // fix later
        sharedInstance.enabled = YES;
        [sharedInstance findAllPrefs];
    });
    return sharedInstance;
}

- (void) findAllPrefs {
    dispatch_queue_t populationQ;
    populationQ = dispatch_queue_create("com.oklasoft.Nuke", nil);
    dispatch_async(populationQ, ^{
        _refreshingPrefs = YES;
        _prefs = [[NSMutableArray alloc] init];
        NSArray *sysPreferences = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[constants sharedInstance].kPrefPanes error:nil];
        
        for (NSString *name in sysPreferences) {
            if ([name containsString:@".prefPane"]){
                NSString *prefPath = [[constants sharedInstance].kPrefPanes stringByAppendingString:name];
                NSString *infoPlistPath = [prefPath stringByAppendingString:@"/Contents/info.plist"];
                NSDictionary *dictionaryForPlist = [[NSDictionary alloc] initWithContentsOfFile:infoPlistPath];
                NSString *bundelID = dictionaryForPlist[@"CFBundleIdentifier"];
                NSString *iconPath = [prefPath stringByAppendingString:[NSString stringWithFormat:@"/Contents/Resources/%@", dictionaryForPlist[@"NSPrefPaneIconFile"]]];
                if (![iconPath containsString:@".icns"]) {
                    iconPath = [iconPath stringByAppendingString:@".icns"];
                }
                NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
                Application *basicPref = [Application applicationWithName:name Path:prefPath BundelIdentifier:bundelID Andicon:iconImage];
                [self.prefs addObject:basicPref];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedAppsArrayNotification object:nil];
            _refreshingPrefs = NO;
        });
    });
}

- (NSArray *)prefsWithTerm:(NSString *)term {
    if (! _refreshingPrefs) {
        NSMutableArray *matchingPrefs = [[NSMutableArray alloc] init];
        for (Application *pref in self.prefs) {
            if ([pref.name containsString:term]) {
                [matchingPrefs addObject:pref];
            }
        }
        return matchingPrefs;
    } else {
        return [[NSArray alloc] init];
    }
}


@end
