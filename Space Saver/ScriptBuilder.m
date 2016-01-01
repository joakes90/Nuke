//
//  ScriptBuilder.m
//  Space Saver
//
//  Created by Justin Oakes on 12/12/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "ScriptBuilder.h"

@implementation ScriptBuilder

+ (NSString *)bashScriptToDeleteArrayOfFile:(NSMutableArray *)files {
    NSString *script = @"#!/bin/bash\n";
    for (NSString *file in files) {
        NSString *fileString = [file stringByExpandingTildeInPath];
        fileString = [fileString stringByReplacingOccurrencesOfString:@" " withString:@"\\\\ "];
        fileString = [fileString stringByReplacingOccurrencesOfString:@"(" withString:@"\\\\("];
        fileString = [fileString stringByReplacingOccurrencesOfString:@")" withString:@"\\\\)"];
        NSString *trashString = [@"~/.Trash/" stringByExpandingTildeInPath];
        trashString = [trashString stringByReplacingOccurrencesOfString:@" " withString:@"\\\\ "];
        NSString *newDir = [NSString stringWithFormat:@"%@/%@", trashString, [[NSNumber numberWithInt:arc4random()] stringValue]];
        NSString *addDirLine = [NSString stringWithFormat:@"mkdir %@ \n", newDir];
        NSString *newLine = [NSString stringWithFormat:@"mv %@ %@", fileString, newDir];
        newLine = [newLine stringByAppendingString:@"\n"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[file stringByExpandingTildeInPath]]) {
            script = [script stringByAppendingString:addDirLine];
            script = [script stringByAppendingString:newLine];
        }
    }
    return script;
}

+ (void) executeScript:(NSString *)script {
    NSString *appleScriptString = [NSString stringWithFormat:@"tell application \"Terminal\" \n do shell script \"%@\" with administrator privileges quit\n end tell", script];
    NSAppleScript *deleteAction = [[NSAppleScript alloc] initWithSource:appleScriptString];
    [deleteAction executeAndReturnError:nil];
}

@end
