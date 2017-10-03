//
//  Application.h
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *path;

@property (strong, nonatomic) NSString *bundelIdentifier;

@property (strong, nonatomic) NSImage *icon;

@property (strong, nonatomic) NSDictionary *appComponets;

@property (assign, nonatomic) BOOL hasSpecificItems;

+ (id) applicationWithName:(NSString *)name Path:(NSString *)path BundelIdentifier:(NSString *)bundelIdentifier Andicon:(NSImage *)icon;

- (NSDictionary *) returnComponetsForApplication;

- (void) setComponetsForApplication;

@end
