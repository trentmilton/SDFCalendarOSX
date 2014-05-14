//
//  SDFCalendarOSXDayViewController.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFCalendarOSXConstants.h"
#import "SDFCalendarOSXDayViewController.h"
#import "SDFCalendarOSXDayView.h"
#import "DateTools.h"

@interface SDFCalendarOSXDayViewController () <SDFCalendarOSXDayViewSelectionDelegate>

@end

@implementation SDFCalendarOSXDayViewController

- (void) awakeFromNib {
    ((SDFCalendarOSXDayView *)self.view).delegate = self;
    self.dayLabel.stringValue = @(self.date.day).stringValue;
    [self deselect];
}


#pragma mark - Public

- (void) select {
    SDFCalendarOSXView *view = (SDFCalendarOSXView *)self.view;
    [view setBackgroundColour:kSDFCalendarOSXSelectedDayBackgroundColour];
}

- (void) deselect {
    SDFCalendarOSXView *view = (SDFCalendarOSXView *)self.view;
    // A few options here for colour
    if (self.currentMonth) {
        [view setBackgroundColour:self.date.isToday ? kSDFCalendarOSXTodayBackgroundColour : kSDFCalendarOSXCurrentMonthDayBackgroundColour];
    } else {
        [view setBackgroundColour:kSDFCalendarOSXNonCurrentMonthDayBackgroundColour];
    }

}

#pragma mark - SDFCalendarOSXDayViewSelectionDelegate

- (void) sdfCalendarOSXDayViewSelected {
    [self select];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sdfCalendarOSXDaySelected:)]) {
        [self.delegate sdfCalendarOSXDaySelected:self];
    }
}

@end
