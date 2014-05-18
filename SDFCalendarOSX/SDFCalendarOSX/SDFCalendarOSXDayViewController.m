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

static NSFont *kSDFCalendarOSXDayFontAndSize;
static NSFont *kSDFCalendarOSXSelectedDayFontAndSize;
static NSColor *kSDFCalendarOSXSelectedDayBackgroundColour;
static NSColor *kSDFCalendarOSXTodayBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayLabelColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayLabelColour;

@interface SDFCalendarOSXDayViewController () <SDFCalendarOSXDayViewSelectionDelegate>

/**
 *  If the nib hasn't loaded yet, this allows selection to happen once the required items are loaded in the nib
 */
@property (nonatomic) BOOL needsSelection;

@end

@implementation SDFCalendarOSXDayViewController

+ (void) setDayFontAndSize:(NSFont *)font {
    kSDFCalendarOSXDayFontAndSize = font;
}

+ (void) setSelectedDayFontAndSize:(NSFont *)font {
    kSDFCalendarOSXSelectedDayFontAndSize = font;
}

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
        self.needsSelection = NO;
    }
    return self;
}

- (void) awakeFromNib {
    ((SDFCalendarOSXDayView *)self.view).delegate = self;

    self.dayLabel.stringValue = @(self.date.day).stringValue;
    
    // Customisation
    if (kSDFCalendarOSXDayFontAndSize && !self.selected) {
        self.dayLabel.font = kSDFCalendarOSXDayFontAndSize;
    }
    
    // Setup background
    SDFCalendarOSXView *view = (SDFCalendarOSXView *)self.view;
    [view setBackgroundColour:kSDFCalendarOSXCurrentMonthDayBackgroundColour];
    
    // Set current day if needed
    if (self.date.isToday) {
        [self.currentDayView setBackgroundColour:kSDFCalendarOSXTodayBackgroundColour];
    }
    
    // Labels
    if (self.currentMonth && kSDFCalendarOSXCurrentMonthDayLabelColour) {
        self.dayLabel.textColor = kSDFCalendarOSXCurrentMonthDayLabelColour;
    } else if (!self.currentMonth && kSDFCalendarOSXNonCurrentMonthDayLabelColour) {
        self.dayLabel.textColor = kSDFCalendarOSXNonCurrentMonthDayLabelColour;
    }
}


#pragma mark - Properties

- (void) setDayLabel:(NSTextField *)dayLabel {
    _dayLabel = dayLabel;
    if (self.selectionView && self.needsSelection) {
        [self select];
    }
}

- (void) setSelectionView:(SDFCalendarOSXView *)selectionView {
    _selectionView = selectionView;
    if (self.dayLabel && self.needsSelection) {
        [self select];
    }
}

#pragma mark - Public

- (void) select {
    _selected = YES;
    if (!self.selectionView || !self.dayLabel) {
        self.needsSelection = YES;
        return;
    }
    self.needsSelection = NO;
    [self.selectionView setBackgroundColour:kSDFCalendarOSXSelectedDayBackgroundColour];
    if (kSDFCalendarOSXDayFontAndSize && kSDFCalendarOSXSelectedDayFontAndSize) {
        self.dayLabel.font = kSDFCalendarOSXSelectedDayFontAndSize;
    }
}

- (void) deselect {
    _selected = NO;
    [self.selectionView setBackgroundColour:[NSColor clearColor]];
    if (kSDFCalendarOSXDayFontAndSize && kSDFCalendarOSXSelectedDayFontAndSize) {
        self.dayLabel.font = kSDFCalendarOSXDayFontAndSize;
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
