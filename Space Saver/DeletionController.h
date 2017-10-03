//
//  DeletionController.h
//  Space Saver
//
//  Created by Justin Oakes on 10/19/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Application.h"

@interface DeletionController : NSObject

- (BOOL)rootItemsPresent;

- (BOOL)appIsRunning:(NSString *)bundelID;

- (BOOL) appAppearsInDock:(Application *)app;

- (BOOL) isOwnedByUser:(NSString *)path;

- (void) appIsStartupItem:(NSString *)app;

- (void) removeComponetFromMac:(NSDictionary *)componets;

- (void) removeApplicationFromMac:(Application *)app;

- (void) removeFromDockApplicationWithBundelIdentifier:(NSString *)ident;

- (void) removeRootItems;

@end
