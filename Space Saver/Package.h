//
//  Package.h
//  Space Saver
//
//  Created by Justin Oakes on 11/22/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Package : NSObject

@property (strong, nonatomic) NSString *packageName;
@property (strong, nonatomic) NSString *idFile;
@property (strong, nonatomic) NSString *imageName;
@property (assign, nonatomic) BOOL needsReboot;
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) NSArray *dockItems;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSArray *recipts;
@property (strong, nonatomic) NSArray *startupItems;

- (id) initFromDictionary:(NSDictionary *)dictionary;

@end
