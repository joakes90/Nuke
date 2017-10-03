//
//  ApplicationCell.h
//  Space Saver
//
//  Created by Justin Oakes on 9/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ApplicationCell : NSTableCellView

@property (strong) IBOutlet NSTextField *nameLabel;

@property (strong) IBOutlet NSButton *appIcon;

@end
