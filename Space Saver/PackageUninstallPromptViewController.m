//
//  PackageUninstallPromptViewController.m
//  Space Saver
//
//  Created by Justin Oakes on 12/5/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "PackageUninstallPromptViewController.h"
#import "PackageUninstallController.h"
#import "AppsController.h"
#import "constants.h"

@interface PackageUninstallPromptViewController ()

@property (strong) IBOutlet NSTextField *messageLabel;
@property (strong) IBOutlet NSImageView *imageView;
@property (strong) IBOutlet NSProgressIndicator *progressBar;

@end

@implementation PackageUninstallPromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.messageLabel.stringValue = self.package.message;
    self.imageView.image = [NSImage imageNamed:self.package.imageName];
    self.title = [NSString stringWithFormat:@"Uninstall %@", self.package.packageName];
    self.progressBar.maxValue = [self.package.files count] + 1;
}

-(void)viewWillAppear {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incrimentProgressBar) name:kFileRemovedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelClicked:) name:kUninstallComplete object:nil];
}

- (void) viewWillDisappear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[AppsController sharedInstance] findAllApplications];
}

- (void) incrimentProgressBar {
    [self.progressBar incrementBy:1.0];
}

- (IBAction)cancelClicked:(id)sender {
    [self dismissViewController:self];
}

- (IBAction)okClicked:(id)sender {
    [[PackageUninstallController sharedInstance] uninstallPackage:self.package];
}

@end
