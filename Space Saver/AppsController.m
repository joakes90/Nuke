//
//  AppsController.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppsController.h"
#import <Cocoa/Cocoa.h>
#import "constants.h"

static NSString *const kApplicationPath = @"/Applications/";

@interface AppsController()

@property (strong, nonatomic) NSMutableArray<Application *> *apps;

@end

@implementation AppsController


+ (instancetype) sharedInstance {
    static AppsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppsController alloc] init];
        [sharedInstance findAllApplications];
    });
    return sharedInstance;
}


- (void)findAllApplications {
    dispatch_queue_t populationQ;
    populationQ = dispatch_queue_create("com.oklasoft.Space-Saver", nil);
    dispatch_async(populationQ, ^{

        _apps = [[NSMutableArray alloc] init];
        NSArray *applications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:kApplicationPath error:nil];
        for (NSString *name in applications) {

            if ([name containsString:@".app"] && ![self appIsBlackListed:name]) {
                NSString *appPath = [kApplicationPath stringByAppendingString:name];
                NSString *infoPlistPath = [appPath stringByAppendingString:@"/Contents/info.plist"];
            
                NSDictionary *dictionaryForPlist = [[NSDictionary alloc] initWithContentsOfFile:infoPlistPath];
                NSString *bundelID = dictionaryForPlist[@"CFBundleIdentifier"];
            
                NSString *iconPath = [appPath stringByAppendingString:[NSString stringWithFormat:@"/Contents/Resources/%@", dictionaryForPlist[@"CFBundleIconFile"]]];
                if (![iconPath containsString:@".icns"]) {
                    iconPath = [iconPath stringByAppendingString:@".icns"];
                }
                NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
            
                Application *basicApplication = [Application applicationWithName:name Path:appPath BundelIdentifier:bundelID Andicon:iconImage];
                [self.apps addObject:basicApplication];
            } else if (![self appIsBlackListed:name]) {
                for (NSString *dirAppName in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[kApplicationPath stringByAppendingString:name] error:nil]) {
                    if ([dirAppName containsString:@".app"] && ![self appIsBlackListed:name]){
                        NSString *appPath = [kApplicationPath stringByAppendingString:[NSString stringWithFormat:@"%@/%@",name, dirAppName]];
                        NSString *infoPlistPath = [appPath stringByAppendingString:@"/Contents/info.plist"];
                        NSDictionary *dictionaryForPlist = [[NSDictionary alloc] initWithContentsOfFile:infoPlistPath];
                        NSString *bundelID = dictionaryForPlist[@"CFBundleIdentifier"];
                        NSString *iconPath = [appPath stringByAppendingString:[NSString stringWithFormat:@"/Contents/Resources/%@", dictionaryForPlist[@"CFBundleIconFile"]]];
                        if (![iconPath containsString:@".icns"]) {
                            iconPath = [iconPath stringByAppendingString:@".icns"];
                        }
                        NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
                        Application *basicApplication = [Application applicationWithName:dirAppName Path:appPath BundelIdentifier:bundelID Andicon:iconImage];
                        [self.apps addObject:basicApplication];

                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedAppsArrayNotification object:nil];
        });
    });
}

- (BOOL)appIsBlackListed:(NSString *)appName {
    BOOL blackListed = NO;
    NSArray *blackListedApps = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blacklist" ofType:@"plist"]];
    for (NSString *name in blackListedApps) {
        if ([appName isEqualToString:name]) {
            blackListed = YES;
        }
    }
    return blackListed;
}

@end
