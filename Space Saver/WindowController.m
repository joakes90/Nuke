//
//  WindowController.m
//  Space Saver
//
//  Created by Justin Oakes on 10/12/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "WindowController.h"
#import "MainViewController.h"
#import "PackageViewController.h"
#import "constants.h"
#import <Quartz/Quartz.h>

@interface WindowController ()

@property (strong) IBOutlet NSToolbarItem *packagesButton;

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    MainViewController *vc = (MainViewController *) self.contentViewController;
    self.delegate = vc;
}



- (IBAction)removeToolbarItemPressed:(id)sender {
    [self.delegate removeButtonPushedInMode:kDeleteMode];
}

- (IBAction)resetToolBarItemPressed:(id)sender {
    [self.delegate removeButtonPushedInMode:kResetMode];
}

- (IBAction)installedPackagesItemPressed:(id)sender {
    if ([self.packagesButton.label isEqualToString:kinstalledPackages]) {
        [self removeMainVC];
    } else {
        [self replaceMainVC];
    }
    
}

- (void) removeMainVC {
    PackageViewController *newVC = [[PackageViewController alloc] init];
    if ([self.window styleMask] & NSFullScreenWindowMask) {
        [newVC.view setFrame:CGRectMake(newVC.view.frame.origin.x, newVC.view.frame.origin.y, self.window.screen.frame.size.width, self.window.screen.frame.size.height - 100)];
        self.window.contentViewController = newVC;
        
        if ([self.packagesButton.label isEqualToString:kinstalledPackages]) {
            self.removeButton.enabled = NO;
            self.removeButton.image = [NSImage imageNamed:ktrashgrey];
            self.resetButton.enabled = NO;
            self.resetButton.image = [NSImage imageNamed:kresetgrey];
            self.packagesButton.label = kinstalledApps;
            self.packagesButton.image = [NSImage imageNamed:kappIcon];
        } else {
            self.removeButton.enabled = YES;
            self.removeButton.image = [NSImage imageNamed:ktrash];
            self.resetButton.enabled = YES;
            self.resetButton.image = [NSImage imageNamed:kreset];
            self.packagesButton.label = kinstalledPackages;
            self.packagesButton.image = [NSImage imageNamed:kpackageIcon];
            self.delegate = (MainViewController *)self.contentViewController;
        }

    } else {
    newVC.view.frame = self.window.contentViewController.view.frame;
    NSImage *oldview = [[NSImage alloc] initWithData:[self.window.contentViewController.view dataWithPDFInsideRect:self.window.contentViewController.view.bounds]];
    NSImageView *oldImageView = [[NSImageView alloc] init];
    oldImageView.frame = newVC.view.frame;
    oldImageView.image = oldview;
    oldImageView.wantsLayer = YES;
    [newVC.view addSubview:oldImageView];
    
    [self.window setContentViewController:newVC];
    CAKeyframeAnimation *slideOut = [CAKeyframeAnimation animation];
    slideOut.keyPath = @"position.y";
    slideOut.values = @[@0, [NSNumber numberWithDouble:(0 - (self.contentViewController.view.frame.size.height + 55))]];
    slideOut.keyTimes = @[@0, @1];
    slideOut.duration = 0.5;
    slideOut.additive = NO;
    slideOut.removedOnCompletion = YES;
    slideOut.delegate = self;
    [oldImageView.layer addAnimation:slideOut forKey:kslideOut];
    [self performSelector:@selector(postAnimationCleanup:) withObject:oldImageView afterDelay:0.6];
    }
}

- (void) replaceMainVC {
    NSStoryboard *sb = [NSStoryboard storyboardWithName:kmainStoryBoard bundle:nil];
    MainViewController *vc = [sb instantiateControllerWithIdentifier:kmainViewController];
    

     if ([self.window styleMask] & NSFullScreenWindowMask) {
        [vc.view setFrame:CGRectMake(vc.view.frame.origin.x, vc.view.frame.origin.y, self.window.screen.frame.size.width, self.window.screen.frame.size.height - 100)];
         self.window.contentViewController = vc;
         [vc.view setNeedsDisplay:YES];
         [vc.populationView removeFromSuperview];
         
         if ([self.packagesButton.label isEqualToString:kinstalledPackages]) {
             self.removeButton.enabled = NO;
             self.removeButton.image = [NSImage imageNamed:ktrashgrey];
             self.resetButton.enabled = NO;
             self.resetButton.image = [NSImage imageNamed:kresetgrey];
             self.packagesButton.label = kinstalledApps;
             self.packagesButton.image = [NSImage imageNamed:kappIcon];
         } else {
             self.removeButton.enabled = YES;
             self.removeButton.image = [NSImage imageNamed:ktrash];
             self.resetButton.enabled = YES;
             self.resetButton.image = [NSImage imageNamed:kreset];
             self.packagesButton.label = kinstalledPackages;
             self.packagesButton.image = [NSImage imageNamed:kpackageIcon];
             self.delegate = (MainViewController *)self.contentViewController;
         }

     } else {
         vc.view.frame = self.window.contentViewController.view.frame;
         NSImage *oldImage = [[NSImage alloc] initWithData:[self.window.contentViewController.view dataWithPDFInsideRect:self.window.contentViewController.view.frame]];
         NSImageView *oldImageView = [[NSImageView alloc] init];
         oldImageView.frame = vc.view.frame;
         oldImageView.image = oldImage;
         
         [self setContentViewController:vc];
         [vc.populationView removeFromSuperview];
         
         NSImage *newImage = [[NSImage alloc] initWithData:[self.window.contentViewController.view dataWithPDFInsideRect:self.window.contentViewController.view.bounds]];
         NSImageView *newImageView = [[NSImageView alloc] init];
         newImageView.frame = vc.view.frame;
         newImageView.image = newImage;
         newImageView.wantsLayer = YES;
         
         [vc.view addSubview:oldImageView];
         [vc.view addSubview:newImageView];
         
         CAKeyframeAnimation *slideIn = [CAKeyframeAnimation animation];
         slideIn.keyPath = @"position.y";
         slideIn.values = @[[NSNumber numberWithDouble:(0 - (self.contentViewController.view.frame.size.height + 55))], @0];
         slideIn.duration = 0.5;
         slideIn.additive = NO;
         slideIn.removedOnCompletion = YES;
         slideIn.delegate = self;
         
         [newImageView.layer addAnimation:slideIn forKey:kslideIn];
         [self performSelector:@selector(postAnimationCleanup:) withObject:oldImageView afterDelay:0.6];
         [self performSelector:@selector(postAnimationCleanup:) withObject:newImageView afterDelay:0.6];
     }
}

- (void) postAnimationCleanup:(NSImageView *)oldView {
    [oldView removeFromSuperview];
    oldView = nil;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([self.packagesButton.label isEqualToString:kinstalledPackages]) {
        self.removeButton.enabled = NO;
        self.removeButton.image = [NSImage imageNamed:ktrashgrey];
        self.resetButton.enabled = NO;
        self.resetButton.image = [NSImage imageNamed:kresetgrey];
        self.packagesButton.label = @"Installed Apps";
        self.packagesButton.image = [NSImage imageNamed:kappIcon];
    } else {
        self.removeButton.enabled = YES;
        self.removeButton.image = [NSImage imageNamed:ktrash];
        self.resetButton.enabled = YES;
        self.resetButton.image = [NSImage imageNamed:kreset];
        self.packagesButton.label = kinstalledPackages;
        self.packagesButton.image = [NSImage imageNamed:kpackageIcon];
        self.delegate = (MainViewController *)self.contentViewController;
    }
}
@end
