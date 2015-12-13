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
        NSString *trashString = [@"~/.Trash/" stringByExpandingTildeInPath];
        trashString = [trashString stringByReplacingOccurrencesOfString:@" " withString:@"\\\\ "];
        NSString *newLine = [NSString stringWithFormat:@"mv %@ %@", fileString, trashString];
        newLine = [newLine stringByAppendingString:@"\n"];
        script = [script stringByAppendingString:newLine];
    }
    return script;
}

@end
