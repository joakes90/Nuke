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

@property (strong, nonatomic) NSArray <Application *> *availableApps;
@property (strong, nonatomic) NSArray <Application *> *availablePrefs;

@end

@implementation MainViewController

-(void)viewWillAppear {
    self.view.wantsLayer = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kUpdatedAppsArrayNotification object:nil];
    _availablePrefs = [[NSArray alloc] init];
    _availableApps = [[NSArray alloc] init];
    [self searchTermWillUpdate:@""];
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
    count += [AppsController sharedInstance].enabled ? [_availableApps count] + 1 : 0;
    count += [PreferencePaneController sharedInstance].enabled ? [_availablePrefs count] + 1 : 0;
    
    return count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    AppsController *apps = [AppsController sharedInstance];
    PreferencePaneController *prefs = [PreferencePaneController sharedInstance];
    
    
    if ([tableColumn.identifier isEqualToString:kcellIdentString] && apps.enabled && row >= 0 && row <= [_availableApps count]) {
        if (row == 0) {
            SectionLabelCell *cell = [tableView makeViewWithIdentifier:ksectionHeaderIndentString owner:self];
            cell.HeaderLabel.stringValue = @"Applications";
            NSTableRowView *appRow = [tableView rowViewAtRow:row makeIfNecessary:NO];
            [appRow setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];

            return cell;
        } else {
            ApplicationCell *cell = [tableView makeViewWithIdentifier:kcellIdentString owner:self];
            cell.nameLabel.stringValue = [_availableApps[row - 1].name stringByReplacingOccurrencesOfString:@".app" withString:@""];
            cell.appIcon.image = _availableApps[row - 1].icon;
            if (row == [_availableApps count] - 1) {
                [self.populationView setHidden:YES];
            }
            return cell;
    }
    }
    
    if ([tableColumn.identifier isEqualToString:kcellIdentString] && prefs.enabled && row >= [_availableApps count] && row <= [_availableApps count] + [_availablePrefs count] + 1) {
        if (row == [_availableApps count] + 1) {
            SectionLabelCell *cell = [tableView makeViewWithIdentifier:ksectionHeaderIndentString owner:self];
            cell.HeaderLabel.stringValue = @"Preference Panes";
            NSTableRowView *prefRow = [tableView rowViewAtRow:row makeIfNecessary:NO];
            [prefRow setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
            return cell;
        } else {
            NSInteger index = (row - [_availableApps count]) - 2;
            ApplicationCell *cell = [tableView makeViewWithIdentifier:kcellIdentString owner:self];
            cell.nameLabel.stringValue = [_availablePrefs[index].name stringByReplacingOccurrencesOfString:@".prefPane" withString:@""];
            cell.appIcon.image = _availablePrefs[index].icon;
            
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


- (void) updateTable {
    [self.tableView reloadData];
    [self.populationView removeFromSuperview];
}

#pragma mark detail view delegate methods
-(void)removeButtonPushedInMode:(NSString *)mode{
        long selectedRow = self.tableView.selectedRow;
        if (selectedRow > 0 || selectedRow != [_availableApps count] + 1) {
            [self setMode:mode];
            [self performSegueWithIdentifier:kverifyDeletionSegue sender:self];
        }
}

-(void)searchTermWillUpdate:(NSString *)term {
    if (term && ![term isEqualToString:@""]) {
        _availableApps = [[AppsController sharedInstance] applicationsWithTerm:term];
        _availablePrefs = [[PreferencePaneController sharedInstance] prefsWithTerm:term];
    } else {
        _availableApps = [AppsController sharedInstance].apps;
        _availablePrefs = [PreferencePaneController sharedInstance].prefs;
    }
    [self updateTable];
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
