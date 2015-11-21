//
//  PackageViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 11/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "PackageViewController.h"
#import "PackageUninstallController.h"

@interface PackageViewController () <NSTableViewDataSource, NSTableViewDelegate>

@end

@implementation PackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[PackageUninstallController sharedInstance] installedPackages].count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"pack"]) {
        NSTableCellView *cell = [tableView makeViewWithIdentifier:@"pack" owner:self];
        NSDictionary *package = [[[PackageUninstallController sharedInstance] installedPackages] objectAtIndex:row];
        NSString *key = [[package allKeys] objectAtIndex:row];
        
        cell.textField.stringValue = key;
        NSImage *packageImage = [NSImage imageNamed:package[key]];
        cell.imageView.image = packageImage;
        
        return cell;
    }
    return nil;
}

@end
