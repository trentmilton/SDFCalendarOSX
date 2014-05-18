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
static NSColor *kSDFCalendarOSXSelectedDayHighlightBackgroundColour;
static NSColor *kSDFCalendarOSXTodayHighlightBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXCurrentMonthDayLabelColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayBackgroundColour;
static NSColor *kSDFCalendarOSXNonCurrentMonthDayLabelColour;
static NSColor *kSDFCalendarOSXDayEventsBackgroundColour;

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

+ (void) setSelectedDayHighlightBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXSelectedDayHighlightBackgroundColour = colour;
}

+ (void) setTodayHighlightBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXTodayHighlightBackgroundColour = colour;
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

+ (void) setDayEventsBackgroundColour:(NSColor *)colour {
    kSDFCalendarOSXDayEventsBackgroundColour = colour;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    // On first load the nib won't be loaded so the select will save a callback for the awake fromNib to select
    if (self.needsSelection) {
        self.needsSelection = NO;
        [self select];
    } else {
        [self deselect];
    }
    
    // Set current day highlight if needed
    if (self.date.isToday) {
        // Only set a background colour if provided
        if (kSDFCalendarOSXTodayHighlightBackgroundColour) {
            [self.todayHighlightView setBackgroundColour:kSDFCalendarOSXTodayHighlightBackgroundColour];
        }
        [self.todayHighlightView setHidden:NO];
    } else {
        [self.todayHighlightView setHidden:YES];
    }
    
    // Initally hide the day events highlight and set the fill colour if one is specified.
    if (self.dayEventsHighlightView) {
        [self.dayEventsHighlightView setHidden:YES];
    }
    if (kSDFCalendarOSXDayEventsBackgroundColour) {
        [self.dayEventsHighlightView setBackgroundColour:kSDFCalendarOSXDayEventsBackgroundColour];
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
    if (self.selectedDayHighlightView && self.needsSelection) {
        [self select];
    }
}

- (void) setSelectedDayHighlightView:(SDFCalendarOSXView *)selectionView {
    _selectedDayHighlightView = selectionView;
    if (self.dayLabel && self.needsSelection) {
        [self select];
    }
}

- (void) setHasDayEvents:(BOOL)hasDayEvents {
    _hasDayEvents = hasDayEvents;
    if (self.dayEventsHighlightView) {
        [self.dayEventsHighlightView setHidden:!hasDayEvents];
    }
}

#pragma mark - Public

- (void) select {
    // We can't select until the views have loaded
    if (!self.selectedDayHighlightView || !self.dayLabel) {
        self.needsSelection = YES;
        return;
    }
    // If this needs selection it should only be called from awakeFromNib and it will be reset to know before hand
    if (self.needsSelection) {
        
    }
    _selected = YES;
    // If an option is set use it, otherewise just show the selection view
    if (kSDFCalendarOSXSelectedDayHighlightBackgroundColour) {
        [self.selectedDayHighlightView setBackgroundColour:kSDFCalendarOSXSelectedDayHighlightBackgroundColour];
    }
    [self.selectedDayHighlightView setHidden:NO];
    if (kSDFCalendarOSXDayFontAndSize && kSDFCalendarOSXSelectedDayFontAndSize) {
        self.dayLabel.font = kSDFCalendarOSXSelectedDayFontAndSize;
    }
}

- (void) deselect {
    _selected = NO;
    // Only clear the background if we have something to fill it with
    if (kSDFCalendarOSXSelectedDayHighlightBackgroundColour) {
        [self.selectedDayHighlightView setBackgroundColour:[NSColor clearColor]];
    }
    [self.selectedDayHighlightView setHidden:YES];
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
