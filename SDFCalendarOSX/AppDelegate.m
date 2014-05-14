//
//  AppDelegate.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 07/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    SDFCalendarOSXCalendarViewController *vc = [SDFCalendarOSX instance];
    vc.delegate = self;
    [self.window.contentView addSubview:vc.view];
}

#pragma mark - SDFCalendarOSXCalendarDelegate

- (void) sdfCalendarOSXCalendarDateSelected:(NSDate *)date {
    NSLog(@"Date selected: %@", date);
}

@end
