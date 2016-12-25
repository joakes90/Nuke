//
//  ViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 9/7/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "MainViewController.h"
#import "DeleteViewController.h"
#import "ApplicationCell.h"
#import "SectionLabelCell.h"
#import "AppsController.h"
#import "PreferencePaneController.h"
#import "Application.h"
#import "constants.h"
#import "DeleteViewController.h"

@interface MainViewController() <NSTableViewDataSource, NSTableViewDelegate>

@property (strong, nonatomic) NSString *mode;

@end

@implementation MainViewController

-(void)viewWillAppear {
    self.view.wantsLayer = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kUpdatedAppsArrayNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mode = [[NSString alloc] init];
    }

-(void)viewWillDisappear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark table view delegate methods

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSInteger count = 0;
    count += [AppsController sharedInstance].enabled ? [[AppsController sharedInstance].apps count] + 1 : 0;
    count += [PreferencePaneController sharedInstance].enabled ? [[PreferencePaneController sharedInstance].prefs count] + 1 : 0;
    
    return count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    AppsController *apps = [AppsController sharedInstance];
    PreferencePaneController *prefs = [PreferencePaneController sharedInstance];
    
    
    if ([tableColumn.identifier isEqualToString:kcellIdentString] && apps.enabled && row >= 0 && row <= [apps.apps count]) {
        if (row == 0) {
            SectionLabelCell *cell = [tableView makeViewWithIdentifier:ksectionHeaderIndentString owner:self];
            cell.HeaderLabel.stringValue = @"Applications";

            return cell;
        } else {
            ApplicationCell *cell = [tableView makeViewWithIdentifier:kcellIdentString owner:self];
            cell.nameLabel.stringValue = [apps.apps[row - 1].name stringByReplacingOccurrencesOfString:@".app" withString:@""];
            cell.appIcon.image = apps.apps[row - 1].icon;
            if (row == [apps.apps count] - 1) {
                [self.populationView setHidden:YES];
            }
            return cell;
    }
    }
    
    if ([tableColumn.identifier isEqualToString:kcellIdentString] && prefs.enabled && row >= [apps.apps count] && row <= [apps.apps count] + [prefs.prefs count] + 1) {
        if (row == [apps.apps count] + 1) {
            SectionLabelCell *cell = [tableView makeViewWithIdentifier:ksectionHeaderIndentString owner:self];
            cell.HeaderLabel.stringValue = @"Preference Panes";
            return cell;
        } else {
            NSInteger index = (row - [apps.apps count]) - 2;
            ApplicationCell *cell = [tableView makeViewWithIdentifier:kcellIdentString owner:self];
            cell.nameLabel.stringValue = [prefs.prefs[index].name stringByReplacingOccurrencesOfString:@".prefPane" withString:@""];
            cell.appIcon.image = prefs.prefs[index].icon;
            
            return cell;
        }
        
    }
    return nil;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    if (row == 0 || row == [[AppsController sharedInstance].apps count] + 1) {
        return 20;
    } else {
        return 80;
    }
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger selectedRowIndex = [self.tableView selectedRow];
    NSTableRowView *selectedRow = [self.tableView rowViewAtRow:selectedRowIndex makeIfNecessary:NO];
    if ([selectedRow.subviews[1] class] == [SectionLabelCell class]) {
        [selectedRow setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
    }
}

- (void) updateTable {
    [self.tableView reloadData];
    [self.populationView removeFromSuperview];
}

#pragma mark detail view delegate methods
-(void)removeButtonPushedInMode:(NSString *)mode{
        long selectedRow = self.tableView.selectedRow;
        if (selectedRow > 0 || selectedRow != [[AppsController sharedInstance].apps count] + 1) {
            [self setMode:mode];
            [self performSegueWithIdentifier:kverifyDeletionSegue sender:self];
        }
}

-(void)serchTermWillUpdate:(NSString *)term {
    NSArray *matchingApps = [[AppsController sharedInstance] applicationsWithTerm:term];
    NSArray *matchingPrefs = [[PreferencePaneController sharedInstance] prefsWithTerm:term];
    NSLog(@"%@", matchingPrefs);
}

- (void)changeModeTo:(NSString *)mode {
    self.mode = mode;
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kverifyDeletionSegue]) {
        NSInteger index = [self.tableView selectedRow] - 1;
        if (index < [[AppsController sharedInstance].apps count]) {
            // yes this is a stupid line but this entire methid is going to be reworked when more data type and search is added later
            Application *app = [AppsController sharedInstance].apps[index];
            [app setComponetsForApplication];
            DeleteViewController *vc = segue.destinationController;
            vc.App = app;
            vc.mode = self.mode;
        } else {
            index = index - ([[AppsController sharedInstance].apps count] + 1);
            Application *app = [PreferencePaneController sharedInstance].prefs[index];
            [app setComponetsForApplication];
            DeleteViewController *vc = segue.destinationController;
            vc.App = app;
            vc.mode = self.mode;
        }
    }
}

@end
