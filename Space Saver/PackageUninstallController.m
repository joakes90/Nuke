//
//  PackageUninstallController.m
//  Space Saver
//
//  Created by Justin Oakes on 11/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "PackageUninstallController.h"

@implementation PackageUninstallController


+ (instancetype) sharedInstance {
    static PackageUninstallController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PackageUninstallController alloc] init];
        sharedInstance.packages = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"packages" ofType:@"plist"]];
    });
    return sharedInstance;
}

- (NSArray *) installedPackages {
    NSMutableArray *installedPackages = [[NSMutableArray alloc] init];
    for (NSDictionary *package in self.packages) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:package[@"idFile"]]) {
            NSDictionary *foundPackage = @{package[@"packageName"] : package[@"imageName"]};
            [installedPackages addObject:foundPackage];
        }
    }
    return installedPackages;
}
@end
