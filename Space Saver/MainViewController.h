//
//  ViewController.h
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WindowController.h"

@interface MainViewController : NSViewController<DetailViewDelegate>

@property (strong) IBOutlet NSView *populationView;
@property (strong) IBOutlet NSTableView *tableView;

@end

