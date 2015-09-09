//
//  Application.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "Application.h"

@implementation Application

+ (id) applicationWithName:(NSString *)name Path:(NSString *)path BundelIdentifier:(NSString *)bundelIdentifier Andicon:(NSImage *)icon {
    Application *application = [[Application alloc] init];
    application.name = name;
    application.path = path;
    application.bundelIdentifier = bundelIdentifier;
    application.icon = icon;
    
    return application;
}
@end
