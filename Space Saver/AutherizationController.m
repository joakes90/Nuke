//
//  AutherizationController.m
//  Nuke
//
//  Created by Justin Oakes on 1/5/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "AutherizationController.h"

@implementation AutherizationController

- (BOOL)appIsRegistered {
    NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:@"serialNumber"];
    if (!sn && ![self appIsInTrial]) {
        return NO;
    } else if ([self appIsInTrial]) {
          return YES;
    } else {
        //verify serial nmber matches email if so yes else no
        return NO;
    }

}

-(BOOL)appIsInTrial {
    NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]]]) {
        NSDate *endOfTrial = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]]];
        BOOL trialValid = [[endOfTrial laterDate:[NSDate new]] isEqual:endOfTrial] ? YES : NO;
        return trialValid;
    } else {
        return NO;
    }
}

+ (void)startTrial {
    NSDate *endOfTrial = [NSDate dateWithTimeIntervalSinceNow:(86400 * 14)];
    NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    NSString *documentPath = [NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Nuke/",[documentURL path]]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Nuke/",[documentURL path]] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [NSKeyedArchiver archiveRootObject:endOfTrial toFile:documentPath];
}

@end
