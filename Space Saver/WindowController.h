//
//  WindowController.h
//  Space Saver
//
//  Created by Justin Oakes on 10/12/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//add before interface
@protocol DetailViewDelegate;

@interface WindowController : NSWindowController

//add in interface
@property (strong, nonatomic) id<DetailViewDelegate> delegate;

@end

//add after interface
@protocol DetailViewDelegate <NSObject>;

//add delegate methods
-(void)removeButtonPushed;

@end
