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
    if (!sn) {
        return NO;
    } else {
        return NO;
        //verify serial nmber matches email if so yes else no
    }

}

@end
