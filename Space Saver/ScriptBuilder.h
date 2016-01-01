//
//  ScriptBuilder.h
//  Space Saver
//
//  Created by Justin Oakes on 12/12/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface ScriptBuilder : NSObject

+ (NSString *)bashScriptToDeleteArrayOfFile:(NSMutableArray *)files;

+ (void) executeScript:(NSString *)script;

@end
