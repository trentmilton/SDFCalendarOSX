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

static NSColor *kSDFCalendarOSXSelectedDayBackgroundColour;
static NSColor *kSDFCalendarOSXTodayBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayLabelColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayLabelColour;

@interface SDFCalendarOSXDayViewController () <SDFCalendarOSXDayViewSelectionDelegate>

@end

@implementation SDFCalendarOSXDayViewController

+ (void) setSelectedDayBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXSelectedDayBackgroundColour = colour;
}

+ (void) setTodayBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXTodayBackgroundColour = colour;
}

+ (void) setCurrentMonthDayBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXCurrentMonthDayBackgroundColour = colour;
}

+ (void) setCurrentMonthDayLabelColour:(NSColor *)colour {
    kSDFCalendarOSXCurrentMonthDayLabelColour = colour;
}

+ (void) setNonCurrentMonthDayBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXNonCurrentMonthDayBackgroundColour = colour;
}

+ (void) setNonCurrentMonthDayLabelColour:(NSColor *)colour {
    kSDFCalendarOSXNonCurrentMonthDayLabelColour = colour;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!kSDFCalendarOSXSelectedDayBackgroundColour) {
            kSDFCalendarOSXSelectedDayBackgroundColour = RGB(6,109,154);
        }
        if (!kSDFCalendarOSXTodayBackgroundColour) {
            kSDFCalendarOSXTodayBackgroundColour = GREY(201);
        }
        if (!kSDFCalendarOSXCurrentMonthDayBackgroundColour) {
            kSDFCalendarOSXCurrentMonthDayBackgroundColour = GREY(221);
        }
        if (!kSDFCalendarOSXNonCurrentMonthDayBackgroundColour) {
            kSDFCalendarOSXNonCurrentMonthDayBackgroundColour = GREY(191);
        }
    }
    return self;
}

- (void) awakeFromNib {
    ((SDFCalendarOSXDayView *)self.view).delegate = self;
    self.dayLabel.stringValue = @(self.date.day).stringValue;
    [self deselect];
    
    // Labels
    if (self.currentMonth && kSDFCalendarOSXCurrentMonthDayLabelColour) {
        self.dayLabel.textColor = kSDFCalendarOSXCurrentMonthDayLabelColour;
    } else if (!self.currentMonth && kSDFCalendarOSXNonCurrentMonthDayLabelColour) {
        self.dayLabel.textColor = kSDFCalendarOSXNonCurrentMonthDayLabelColour;
    }
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
