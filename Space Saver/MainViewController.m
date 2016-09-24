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
#import "AppsController.h"
#import "Application.h"
#import "constants.h"
#import "DeleteViewController.h"

@interface MainViewController() <NSTableViewDataSource, NSTableViewDelegate>


@property (strong) IBOutlet NSProgressIndicator *spinner;


@property (strong, nonatomic) NSString *mode;

@end

@implementation MainViewController

-(void)viewWillAppear {
    self.view.wantsLayer = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kUpdatedAppsArrayNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.spinner startAnimation:nil];
    self.mode = [[NSString alloc] init];
    }

-(void)viewWillDisappear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

//table view delegate methods

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[AppsController sharedInstance].apps count];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:kcellIdentString] && [[AppsController sharedInstance].apps count] > row) {
        ApplicationCell *cell = [tableView makeViewWithIdentifier:kcellIdentString owner:self];
        cell.nameLabel.stringValue = [[AppsController sharedInstance].apps[row].name stringByReplacingOccurrencesOfString:@".app" withString:@""];
        cell.appIcon.image = [AppsController sharedInstance].apps[row].icon;
        if (row == [[AppsController sharedInstance].apps count] - 1) {
            [self.populationView setHidden:YES];
        }
        return cell;
    }
        return nil;
}

-(void)tableViewSelectionIsChanging:(NSNotification *)notification {
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 80;
}

- (void) updateTable {
    [self.tableView reloadData];
    [self.populationView removeFromSuperview];
}

// detail view delegate methods
-(void)removeButtonPushedInMode:(NSString *)mode{
        long selectedRow = self.tableView.selectedRow;
        if ( selectedRow >= 0) {
            [self setMode:mode];
            [self performSegueWithIdentifier:kverifyDeletionSegue sender:self];
        }
}

- (void)changeModeTo:(NSString *)mode {
    self.mode = mode;
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kverifyDeletionSegue]) {
        Application *app = [AppsController sharedInstance].apps[[self.tableView selectedRow]];
        [app setComponetsForApplication];
        DeleteViewController *vc = segue.destinationController;
        vc.App = app;
        vc.mode = self.mode;
    }
}


@end
