//
//  PackageViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 11/8/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "PackageViewController.h"
#import "PackageUninstallController.h"
#import "PackageUninstallPromptViewController.h"
#import "constants.h"

@interface PackageViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSTableView *table;

@end

@implementation PackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unInstallComplete) name:kUninstallComplete object:nil];
}

- (IBAction)uninstallSelectedPackage:(id)sender {
    if ([self.table selectedRow] >= 0) {
        Package *package = [[[PackageUninstallController sharedInstance] installedPackages] objectAtIndex:[self.table selectedRow]];
        PackageUninstallPromptViewController *promptView = [[PackageUninstallPromptViewController alloc] init];
        promptView.package = package;
        [self presentViewControllerAsModalWindow:promptView];
    }
}

//tableview delegate methods
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[[PackageUninstallController sharedInstance] installedPackages] count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"pack"]) {
        NSTableCellView *cell = [tableView makeViewWithIdentifier:@"pack" owner:self];
        Package *package = [[[PackageUninstallController sharedInstance] installedPackages] objectAtIndex:row];
        
        cell.textField.stringValue = package.packageName;
        NSImage *packageImage = [NSImage imageNamed:package.imageName];
        [cell.imageView setImage:packageImage];
        
        return cell;
    }
    return nil;
}

- (void) unInstallComplete {
    [self.table reloadData];
}

@end
