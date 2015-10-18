//
//  DeleteViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/13/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "DeleteViewController.h"

@interface DeleteViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSTextField *ViewLabel;

@property (strong) IBOutlet NSTableView *tableView;

@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.ViewLabel.stringValue = [NSString stringWithFormat:@"Remove these items with %@?", self.App.name];
}
- (IBAction)dismisView:(id)sender {
    [self dismissViewController:self];
}


//tableview datasource and delegate methods

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSArray *keys = [self.App.appComponets allKeys];
    NSInteger numberOfEnteries = keys.count;
    
    for (NSString *key in keys) {
        NSArray *filesArray = self.App.appComponets[key];
        numberOfEnteries += filesArray.count;
    }
    return numberOfEnteries;
}

//-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    
//}
@end
