//
//  SDFCalendarOSXCalendarViewController.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

@class SDFCalendarOSXMonthView;

#import "SDFCalendarOSXDayViewController.h"

@protocol SDFCalendarOSXCalendarDelegate <NSObject>

- (void) sdfCalendarOSXCalendarDateSelected:(NSDate *)date;

@end

@interface SDFCalendarOSXCalendarViewController : NSViewController <SDFCalendarOSXDaySelectionDelegate>

@property (nonatomic, weak) IBOutlet NSTextField *yearLabel;
@property (nonatomic, weak) IBOutlet NSTextField *monthLabel;
@property (nonatomic, weak) IBOutlet NSButton *previousMonthButton;
@property (nonatomic, weak) IBOutlet NSButton *nextMonthButton;
@property (nonatomic, strong) IBOutlet SDFCalendarOSXMonthView *monthView;
@property (nonatomic, strong) id <SDFCalendarOSXCalendarDelegate> delegate;

#pragma mark - Actions

- (IBAction) previousMonth:(id)sender;
- (IBAction) nextMonth:(id)sender;

@end
