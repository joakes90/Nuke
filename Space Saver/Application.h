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

@property (assign, nonatomic) float size;

@property (strong, nonatomic) NSImage *icon;

+ (id) applicationWithName:(NSString *)name Path:(NSString *)path BundelIdentifier:(NSString *)bundelIdentifier icon:(NSImage *)icon AndSize:(float)size;

@end
