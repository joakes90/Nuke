//
//  DeleteViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/13/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "DeleteViewController.h"
#import "ComponetsTableViewCell.h"
#import "constants.h"
#import "DeletionController.h"

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

- (IBAction)deleteApp:(id)sender {
    DeletionController *deleter = [[DeletionController alloc] init];
    if ([deleter appIsRunning:self.App]) {
        // warn user that app is running
    } else {
       // remove selected componets
    }
}


- (NSString *)typeNameForKey:(NSString *)key {
    if ([key isEqualToString:kUserPrefs]) {
        return @"User Prefrences";
    } else if ([key isEqualToString:kUserCaches]){
        return @"Cache";
    } else if ([key isEqualToString:kUserAppSupport]) {
        return @"Application Support";
    } else if ([key isEqualToString:kUserAutosave]) {
        return @"Auto Saves";
    } else if ([key isEqualToString:kContainers]) {
        return @"Container";
    } else if ([key isEqualToString:kSaveState]) {
        return @"Save State";
    } else if ([key isEqualToString:kRootPrefs]) {
        return @"Root Prefrences";
    } else {
        return @"Misc";
    }
}

//tableview datasource and delegate methods

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50.0;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSArray *keys = [self.App.appComponets allKeys];
    NSInteger numberOfEnteries = 0;
    
    for (NSString *key in keys) {
        NSArray *filesArray = self.App.appComponets[key];
        numberOfEnteries += filesArray.count;
    }
    return numberOfEnteries;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSMutableArray *orderOfColoms = [[NSMutableArray alloc] init];
    NSArray *keys = [self.App.appComponets allKeys];
    for (NSString *key in keys) {
        NSArray *objects = self.App.appComponets[key];
        for (NSString *object in objects) {
            [orderOfColoms addObject:@{key : object}];
        }
    }
    ComponetsTableViewCell *cell = [tableView makeViewWithIdentifier:@"componets" owner:self];
    NSDictionary *componets = orderOfColoms[row];
    NSString *type = [componets allKeys][0];
    NSString *name = componets[type];
    
    cell.typeLabel.stringValue = [self typeNameForKey:type];
    cell.itemLabel.stringValue = name;
    
    return cell;
}
@end
