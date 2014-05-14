//
//  SDFCalendarOSXDayViewController.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

@class SDFCalendarOSXDayViewController;

@protocol SDFCalendarOSXDaySelectionDelegate <NSObject>

- (void) sdfCalendarOSXDaySelected:(SDFCalendarOSXDayViewController *)dayViewController;

@end

@interface SDFCalendarOSXDayViewController : NSViewController

@property (nonatomic, weak) IBOutlet NSTextField *dayLabel;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id <SDFCalendarOSXDaySelectionDelegate> delegate;
@property (nonatomic) BOOL currentMonth;

#pragma mark - Public

- (void) select;
- (void) deselect;

@end
