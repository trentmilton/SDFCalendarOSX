//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 shaydes.dsgn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
