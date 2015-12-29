//
//  Package.m
//  Space Saver
//
//  Created by Justin Oakes on 11/22/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "Package.h"

@implementation Package

- (id) initFromDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.packageName = dictionary[@"packageName"];
        self.idFile = dictionary[@"idFile"];
        self.imageName = dictionary[@"imageName"];
        self.needsReboot = [dictionary[@"needsReboot"] boolValue];
        self.files = dictionary[@"files"];
        self.dockItems = dictionary[@"dockItems"];
        self.message = dictionary[@"message"];
        self.recipts = dictionary[@"recipts"];
        self.startupItems = dictionary[@"startupItems"];
    }
    return self;
}

@end
