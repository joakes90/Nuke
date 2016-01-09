//
//  AutherizationController.h
//  Nuke
//
//  Created by Justin Oakes on 1/5/16.
//  Copyright © 2016 oklasoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutherizationController : NSObject

- (BOOL)appIsRegistered;

- (BOOL)appIsInTrial;

- (BOOL)trialHasExpired;

- (BOOL) validateWithEmail:(NSString *)email andSerial:(NSString *)serial;

+ (void)startTrial;

@end
