//
//  AppsController.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "AppsController.h"
#import <Cocoa/Cocoa.h>

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
    _apps = [[NSMutableArray alloc] init];
    NSArray *applications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:kApplicationPath error:nil];
    for (NSString *name in applications) {
        if ([name containsString:@".app"]) {
            NSString *appPath = [kApplicationPath stringByAppendingString:name];
            NSString *infoPlistPath = [appPath stringByAppendingString:@"/Contents/info.plist"];
            
            NSDictionary *dictionaryForPlist = [[NSDictionary alloc] initWithContentsOfFile:infoPlistPath];
            NSString *bundelID = dictionaryForPlist[@"CFBundleIdentifier"];
            
            NSString *iconPath = [appPath stringByAppendingString:[NSString stringWithFormat:@"/Contents/Resources/%@", dictionaryForPlist[@"CFBundleIconFile"]]];
            NSImage *iconImage = [[NSImage alloc] initWithContentsOfFile:iconPath];
            
            NSDictionary *appAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:appPath error:nil];
            float size = [appAttributes[@"NSFileSize"] floatValue];
            Application *basicApplication = [Application applicationWithName:name Path:appPath BundelIdentifier:bundelID icon:iconImage AndSize:size];
            [self.apps addObject:basicApplication];
        }
    }

}

@end
