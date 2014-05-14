//
//  AppDelegate.h
//  SDFCalendarOSX
//
//  Created by Trent Milton on 07/05/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SDFCalendarOSX/SDFCalendarOSX.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, SDFCalendarOSXCalendarDelegate>

@property (assign) IBOutlet NSWindow *window;

@end
