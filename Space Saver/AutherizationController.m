//
//  AutherizationController.m
//  Nuke
//
//  Created by Justin Oakes on 1/5/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import "AutherizationController.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AutherizationController

- (BOOL)appIsRegistered {
    NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:@"serial"];
    if (!sn && ![self appIsInTrial]) {
        return NO;
    } else if ([self appIsInTrial]) {
          return YES;
    } else {
        //verify serial nmber matches email if so yes else no
        return [self validateWithEmail:[[NSUserDefaults standardUserDefaults] stringForKey:@"email"] andSerial:[[NSUserDefaults standardUserDefaults] stringForKey:@"serial"]];
    }

}

- (BOOL)appIsInTrial {
    NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]]]) {
            return [self trialHasExpired] ? NO : YES;
    } else {
        return NO;
    }
}

- (BOOL)trialHasExpired {
    NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]]]) {
        NSURL *documentURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
        NSDate *endOfTrial = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/Nuke/nuke.okd",[documentURL path]]];
        BOOL trialValid = [[endOfTrial laterDate:[NSDate new]] isEqual:endOfTrial] ? YES : NO;
        return !trialValid;
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

- (BOOL) validateWithEmail:(NSString *)email andSerial:(NSString *)serial {
    NSString *prefix = [serial substringToIndex:5];
    serial = [[serial stringByReplacingOccurrencesOfString:@"-" withString:@""] substringFromIndex:5];
    NSString *validHash = [self MD5String:email];
    if ([[prefix uppercaseString] isEqualToString:@"OKNUK"] && [[serial uppercaseString] isEqualToString:[validHash substringToIndex:20]]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)MD5String:(NSString *)string {
    const char *cstr = [string cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end
