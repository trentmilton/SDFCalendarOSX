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
//  SDFCalendarOSXCalendarViewController.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

@class SDFCalendarOSXMonthView;

#import "SDFCalendarOSXDayViewController.h"
#import "SDFCalendarOSXView.h"

@protocol SDFCalendarOSXCalendarDelegate <NSObject>

- (void) sdfCalendarOSXCalendarDateSelected:(NSDate *)date;

@end

/**
 *  Handles display of the calendar. This will generate all the days and add them to a month NSView. The calendar handles previous / next month cycling and loading of the year / month header.
 */
@interface SDFCalendarOSXCalendarViewController : NSViewController <SDFCalendarOSXDaySelectionDelegate>

@property (nonatomic, weak) IBOutlet SDFCalendarOSXView *headerView;
@property (nonatomic, weak) IBOutlet NSTextField *yearLabel;
@property (nonatomic, weak) IBOutlet NSTextField *monthLabel;
@property (nonatomic, weak) IBOutlet NSButton *previousMonthButton;
@property (nonatomic, weak) IBOutlet NSButton *nextMonthButton;
@property (nonatomic, strong) IBOutlet SDFCalendarOSXMonthView *monthView;
@property (nonatomic, strong) id <SDFCalendarOSXCalendarDelegate> delegate;
@property (nonatomic, strong) NSString *currentMonthDayViewNibName;
@property (nonatomic, strong) NSString *nonCurrentMonthDayViewNibName;

+ (void) setHeaderBackgroundColour:(NSColor *)colour;

#pragma mark - Actions

- (IBAction) previousMonth:(id)sender;
- (IBAction) nextMonth:(id)sender;

@end
