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
//  SDFCalendarOSXDayViewController.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

@class SDFCalendarOSXDayViewController;
@class SDFCalendarOSXView;

@protocol SDFCalendarOSXDaySelectionDelegate <NSObject>

- (void) sdfCalendarOSXDaySelected:(SDFCalendarOSXDayViewController *)dayViewController;

@end

@interface SDFCalendarOSXDayViewController : NSViewController

@property (nonatomic, weak) IBOutlet NSTextField *dayLabel;
@property (nonatomic, weak) IBOutlet SDFCalendarOSXView *todayHighlightView;
@property (nonatomic, weak) IBOutlet SDFCalendarOSXView *selectedDayHighlightView;
/**
 *  Used to show that there is more information for a given day if you are using the calendar for an event based app, e.g. appointments or workouts might be present for this date. Default is to not show and must be called after the nib has loaded.
 */
@property (nonatomic, weak) IBOutlet SDFCalendarOSXView *dayEventsHighlightView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id <SDFCalendarOSXDaySelectionDelegate> delegate;
@property (nonatomic) BOOL currentMonth;
@property (nonatomic, readonly) BOOL selected;
/**
 *  When set this will cause the dayEventsHighlightView to show (YES) or hide (NO).
 */
@property (nonatomic) BOOL hasDayEvents;
/**
 *  Font and size when day cell is not selected (Default state).
 *
 *  @param font Font and size to apply by default when not selected.
 */
+ (void) setDayFontAndSize:(NSFont *)font;
/**
 *  Font and size when day cell selected.
 *
 *  This requires that setDayFontAndSize has been also set (in order for it be reverted to).
 *
 *  @param font Font and size to apply on selection.
 */
+ (void) setSelectedDayFontAndSize:(NSFont *)font;
/**
 *  When set this will fill the attached selectionView.
 *
 *  @param colour Colour to fill the selectionView with
 */
+ (void) setSelectedDayHighlightBackgroundColour:(NSColor *)colour;
+ (void) setTodayHighlightBackgroundColour:(NSColor *)colour;
/**
 *  When set this will fill the attached currentDayView.
 *
 *  @param colour Colour to fill the currentDayView with.
 */
+ (void) setCurrentMonthDayBackgroundColour:(NSColor *)colour;
+ (void) setCurrentMonthDayLabelColour:(NSColor *)colour;
+ (void) setNonCurrentMonthDayBackgroundColour:(NSColor *)colour;
+ (void) setNonCurrentMonthDayLabelColour:(NSColor *)colour;
+ (void) setDayEventsBackgroundColour:(NSColor *)colour;
/**
 *  The colour to use when hovering over day. If not set no hover will happen.
 *
 *  @param colour Hover highlight colour.
 */
+ (void) setDayHighlightBackgroundColour:(NSColor *)colour;

#pragma mark - Public

- (void) setup;
- (void) select;
- (void) deselect;

@end
