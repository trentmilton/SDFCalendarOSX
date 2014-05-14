//
//  SDFCalendarOSX.m
//  SDFCalendarOSX
//
//  Created by Trent Milton on 12/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "SDFCalendarOSX.h"

@implementation SDFCalendarOSX

+ (SDFCalendarOSXCalendarViewController *) instance {
  return [[SDFCalendarOSXCalendarViewController alloc] initWithNibName:@"SDFCalendarOSXCalendar" bundle:nil];
}

@end

