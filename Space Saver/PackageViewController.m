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

@property (strong) IBOutlet NSTableView *table;
@property (strong, nonatomic) NSArray *packages;

@end

@implementation PackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.packages = [[PackageUninstallController sharedInstance] installedPackages];
}

- (IBAction)uninstallSelectedPackage:(id)sender {
    Package *package = [self.packages objectAtIndex:[self.table selectedRow]];
    [[PackageUninstallController sharedInstance] uninstallPackage:package];
}

//tableview delegate methods
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.packages.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"pack"]) {
        NSTableCellView *cell = [tableView makeViewWithIdentifier:@"pack" owner:self];
        Package *package = [[[PackageUninstallController sharedInstance] installedPackages] objectAtIndex:row];
        
        cell.textField.stringValue = package.packageName;
        NSImage *packageImage = [NSImage imageNamed:package.imageName];
        cell.imageView.image = packageImage;
        
        return cell;
    }
    return nil;
}

@end
