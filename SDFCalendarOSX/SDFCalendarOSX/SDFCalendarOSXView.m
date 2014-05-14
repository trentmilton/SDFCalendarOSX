//
//  SDFCalendarOSXView.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFCalendarOSXView.h"

@interface SDFCalendarOSXView ()

@property (nonatomic, strong) NSColor *backgroundColour;

@end

@implementation SDFCalendarOSXView

- (void) drawRect:(NSRect)dirtyRect {
    // set any NSColor for filling, say white:
    if (self.backgroundColour) {
        [self.backgroundColour setFill];
        NSRectFill(dirtyRect);
    }
    [super drawRect:dirtyRect];
}

- (void) setBackgroundColour:(NSColor *)colour {
    _backgroundColour = colour;
    [self setNeedsDisplay:YES];
}

@end
