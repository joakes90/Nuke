//
//  greyView.m
//  Space Saver
//
//  Created by Justin Oakes on 11/20/15.
//  Copyright © 2015 oklasoft. All rights reserved.
//

#import "greyView.h"

@implementation greyView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 0.925f, 0.925f, 0.925f, 1.00f);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

@end
