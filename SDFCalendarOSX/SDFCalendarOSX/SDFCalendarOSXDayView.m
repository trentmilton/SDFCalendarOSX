//
//  SDFCalendarOSXDayView.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFCalendarOSXDayView.h"

@implementation SDFCalendarOSXDayView

- (void) mouseDown:(NSEvent *)theEvent {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sdfCalendarOSXDayViewSelected)]) {
        [self.delegate sdfCalendarOSXDayViewSelected];
    }
}

@end
