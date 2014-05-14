//
//  SDFCalendarOSXConstants.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 14/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#define RGB(r, g, b)                                        [NSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define GREY(v)                                             RGB(v, v, v)

#define kSDFCalendarOSXGrid                                 CGPointMake(7,6)

#define kSDFCalendarOSXHeaderBackgroundColour               GREY(101)
#define kSDFCalendarOSXCurrentMonthDayBackgroundColour      GREY(221)
#define kSDFCalendarOSXNonCurrentMonthDayBackgroundColour   GREY(191)
#define kSDFCalendarOSXSelectedDayBackgroundColour          RGB(6,109,154)
#define kSDFCalendarOSXTodayBackgroundColour                GREY(201)