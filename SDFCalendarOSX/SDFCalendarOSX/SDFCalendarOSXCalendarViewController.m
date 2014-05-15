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
//  SDFCalendarOSXCalendarViewController.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFCalendarOSXCalendarViewController.h"
#import "SDFCalendarOSXConstants.h"
#import "SDFCalendarOSXMonthView.h"
#import "DateTools.h"

@interface SDFCalendarOSXCalendarViewController ()

@property (nonatomic, strong) NSArray *dayVCs;
@property (nonatomic, strong) SDFCalendarOSXDayViewController *currentDayVC;
@property (nonatomic, strong) NSDate *currentMonthDate;

@end

@implementation SDFCalendarOSXCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentMonthDayViewNibName = @"SDFCalendarOSXCurrentMonthDay";
        self.nonCurrentMonthDayViewNibName = @"SDFCalendarOSXNonCurrentMonthDay";
    }
    return self;
}

- (void) awakeFromNib {
    
    // Background
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor grayColor].CGColor;
    
    self.currentMonthDate = [self startOfMonthDate:[NSDate new]];
    
    [self setupMonth];
}

#warning TODO - Look for memory leak

- (void) setupMonth {
    // Some warnings to make sure the below works as expected
    NSAssert((int)self.monthView.frame.size.width % (int)kSDFCalendarOSXGrid.x == 0, @"SDFCalendarOSXMonthView width must be a multiple of kSDFCalendarOSXGrid.x");
    NSAssert((int)self.monthView.frame.size.height % (int)kSDFCalendarOSXGrid.y == 0, @"SDFCalendarOSXMonthView height must be a multiple of kSDFCalendarOSXGrid.y");
    
    // Resets
    self.dayVCs = nil;
    for (NSView *sv in [self.monthView.subviews copy]) {
        [sv removeFromSuperview];
    }
    
    NSDate *today = [NSDate new];
    today = [NSDate new];
    today = [today dateBySubtractingHours:today.hour];
    today = [today dateBySubtractingMinutes:today.minute];
    today = [today dateBySubtractingSeconds:today.second];
    
    // We need to get the starting day for the grid
    // Work out what the first day of the month was in terms of the weekday
    // Reset to midnight so the dates look nice on debug printout
    NSDate *som = [self.currentMonthDate dateBySubtractingDays:self.currentMonthDate.day - 1];
    // What is the start of month day of the week (Sunday = 0)
    NSInteger somdow = som.weekday;
    if (somdow == 1) {
        somdow = 8;
    }
    // Whatever it is is how far we want to go back from the start of the month to show on the first grid entry
    NSDate *currentGridDate = [som dateBySubtractingDays:somdow - 1];
    
    // Fill the month view with as a kSDFCalendarOSXGrid
    // Load them into the view from the top left then shift across right. Move down and repeat from left to right until we reach the bottom right.
    NSMutableArray *dvcs = [NSMutableArray new];
    CGSize daySize = CGSizeMake(self.monthView.frame.size.width / kSDFCalendarOSXGrid.x, self.monthView.frame.size.height / kSDFCalendarOSXGrid.y);
    for (int y = 1; y <= kSDFCalendarOSXGrid.y; y ++) {
        for (int x = 0; x < kSDFCalendarOSXGrid.x; x ++) {
            NSString *nibName = currentGridDate.month == self.currentMonthDate.month ? self.currentMonthDayViewNibName : self.nonCurrentMonthDayViewNibName;
            SDFCalendarOSXDayViewController *dvc = [[SDFCalendarOSXDayViewController alloc] initWithNibName:nibName bundle:nil];
            dvc.delegate = self;
            dvc.date = [currentGridDate copy];
            dvc.currentMonth = currentGridDate.month == self.currentMonthDate.month;
            
            BOOL noCurrentDaySetAndToday = !self.currentDayVC && [currentGridDate isToday];
            BOOL currentDaySetAndDateMatches = self.currentDayVC && [self.currentDayVC.date isEqualToDate:currentGridDate];
            if (noCurrentDaySetAndToday || currentDaySetAndDateMatches) {
                self.currentDayVC = dvc;
                [dvc select];
            }
            
            CGRect dayRect = dvc.view.frame;
            
            // Set the size to ensure that it is 1/kSDFCalendarOSXGrid.x the width of the month view and 1/kSDFCalendarOSXGrid.y it's height. Creating a kSDFCalendarOSXGrid.
            dayRect.size = daySize;
            
            // Work out it's position
            CGFloat dayX = daySize.width * x;
            CGFloat dayY = self.monthView.frame.size.height - daySize.height * y;
            dayRect.origin = CGPointMake(dayX, dayY);
            // Finally set it back to the frame
            dvc.view.frame = dayRect;
            [self.monthView addSubview:dvc.view];
            
            currentGridDate = [currentGridDate dateByAddingDays:1];
            [dvcs addObject:dvc];
        }
    }
    
    // Month / Year labels
    self.monthLabel.stringValue = [self.currentMonthDate formattedDateWithFormat:@"MMM"];
    self.yearLabel.stringValue = @(self.currentMonthDate.year).stringValue;
    self.dayVCs = [dvcs copy];
}

#pragma mark - Actions

- (IBAction) previousMonth:(id)sender {
    self.currentMonthDate = [self.currentMonthDate dateBySubtractingMonths:1];
    [self setupMonth];
}

- (IBAction) nextMonth:(id)sender {
    self.currentMonthDate = [self.currentMonthDate dateByAddingMonths:1];
    [self setupMonth];
}

#pragma mark - SDFCalendarOSXDaySelectionDelegate

- (void) sdfCalendarOSXDaySelected:(SDFCalendarOSXDayViewController *)dayViewController {
    NSDate *selectedDate = [dayViewController.date copy];
    
    if (dayViewController.currentMonth) {
        [self.currentDayVC deselect];
        self.currentDayVC = dayViewController;
        [self.currentDayVC select];
    } else {
        // Reset the date to start of the appropriate month
        self.currentMonthDate = [self startOfMonthDate:dayViewController.date];
        // Set the date to selected
        [self setupMonth];
        
        
        // Search through the new VCs to select the date from the previous / next month
        for (SDFCalendarOSXDayViewController *dvc in self.dayVCs) {
            if ([dvc.date isEqualToDate:selectedDate]) {
                [self.currentDayVC deselect];
                self.currentDayVC = dvc;
                [self.currentDayVC select];
                break;
            }
        }
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sdfCalendarOSXCalendarDateSelected:)]) {
        [self.delegate sdfCalendarOSXCalendarDateSelected:selectedDate];
    }
}

#pragma mark - Private

- (NSDate *) startOfMonthDate:(NSDate *)date {
    NSDate *tempDate = [date copy];
    tempDate = [tempDate dateBySubtractingDays:tempDate.day - 1];
    tempDate = [self startOfDayDate:tempDate];
    return tempDate;
}

- (NSDate *) startOfDayDate:(NSDate *)date {
    NSDate *tempDate = [date copy];
    tempDate = [tempDate dateBySubtractingHours:tempDate.hour];
    tempDate = [tempDate dateBySubtractingMinutes:tempDate.minute];
    tempDate = [tempDate dateBySubtractingSeconds:tempDate.second];
    return tempDate;
}

@end
