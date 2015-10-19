//
//  ComponetsTableViewCell.h
//  Space Saver
//
//  Created by Justin Oakes on 10/15/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ComponetsTableViewCell : NSTableCellView

@property (strong) IBOutlet NSTextField *itemLabel;

@property (strong) IBOutlet NSTextField *typeLabel;

@property (strong) IBOutlet NSImageView *typeImage;

@property (strong) IBOutlet NSButton *removeCheckBox;

@end
