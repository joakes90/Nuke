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
#import <Quartz/Quartz.h>
#import "AppRunningViewController.h"
#import "AppsController.h"

@interface DeleteViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSTextField *ViewLabel;

@property (strong) IBOutlet NSTableView *tableView;

@property (strong, nonatomic) DeletionController *deleter;

@end

@implementation DeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.ViewLabel.stringValue = [self.mode isEqualToString:kDeleteMode]? [NSString stringWithFormat:@"Remove these items with %@?", self.App.name] : [NSString stringWithFormat:@"Reset %@ to factory settings and remove data?", self.App.name];
    self.deleter = [[DeletionController alloc] init];
}
- (IBAction)dismisView:(id)sender {
    [self dismissViewController:self];
}

- (IBAction)deleteApp:(id)sender {
    
    if ([self.deleter appIsRunning:self.App]) {
        // warn user that app is running
        [self performSegueWithIdentifier:@"appRunning" sender:self];
    } else {
       // remove selected componets
        for (NSInteger i = 0 ; i < [self.tableView numberOfRows]; i++) {
            ComponetsTableViewCell *cell = [self.tableView viewAtColumn:0 row:i makeIfNecessary:YES];
            if (cell.removeCheckBox.state == 1){
                [self.deleter removeComponetFromMac:cell.componet];
                
                //animation to slide away cell
                CAKeyframeAnimation *slide = [CAKeyframeAnimation animation];
                slide.keyPath = @"position.x";
                slide.values = @[@0, [NSNumber numberWithDouble:(0 - (self.view.frame.size.width + 15))]];
                slide.keyTimes = @[@0, @1];
                slide.duration = 0.5;
                slide.additive = NO;
                
                [cell.layer addAnimation:slide forKey:@"slide"];
            }
        }
        if ([self.mode isEqualToString:kDeleteMode]) {
            [self.deleter removeApplicationFromMac:self.App.name];
        }
        [self dismissViewController:self];
        [[AppsController sharedInstance] findAllApplications];
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


-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"appRunning"]) {
        AppRunningViewController *vc = segue.destinationController;
        vc.app = self.App;
    }

}
//tableview datasource and delegate methods

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 50.0;
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    return NO;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSArray *keys = [self.App.appComponets allKeys];
    NSInteger numberOfEnteries = 0;
    
    for (NSString *key in keys) {
        NSArray *filesArray = self.App.appComponets[key];
        numberOfEnteries += filesArray.count;
    }
    if (![self.App.path isEqualToString:[NSString stringWithFormat:@"/Applications/%@", self.App.name]]) {
        return numberOfEnteries ++;
    } else {
    return numberOfEnteries;
    }
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
    if (row < orderOfColoms.count) {
    
        NSDictionary *componets = orderOfColoms[row];
        NSString *type = [componets allKeys][0];
        NSString *name = componets[type];
    
        cell.componet = componets;
        cell.typeLabel.stringValue = [self typeNameForKey:type];
        cell.itemLabel.stringValue = [name stringByReplacingOccurrencesOfString:@".app" withString:@""];
        cell.wantsLayer = YES;
    
        return cell;
    } else {
        cell.componet = @{kAppFolder: [self.App.path stringByReplacingOccurrencesOfString:self.App.name withString:@""]};
        cell.typeLabel.stringValue = @"Application Folder";
        cell.itemLabel.stringValue = [self.App.path stringByReplacingOccurrencesOfString:self.App.name withString:@""];
        cell.wantsLayer = YES;
        
        return cell;
    }
            
}
@end
