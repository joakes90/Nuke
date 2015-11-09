//
//  PackageUninstallController.h
//  Space Saver
//
//  Created by Justin Oakes on 11/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackageUninstallController : NSObject

@property (strong, nonatomic) NSArray *packages;

+ (instancetype) sharedInstance;

- (NSArray *) installedPackages;

@end
