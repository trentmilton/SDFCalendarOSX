## SDFCalendarOSX

A basic calendar for OSX (Yes, OSX, NOT iOS as there are a million of them out there). This is written to fill the lack of customisation in the NSDatePicker that apple provides. It features very basic functionality:
- Date selection delegate.
- Highlighting of currently selected date.
- Highlighting of current date.

**Note:** to use this and modify the calendar you will need a moderate grasp of Objective-C. This framework can be a simple drop in and your good to go if you don't care too much about the look of it. However if you want to modify the look and feel you will need some skills.

## Installation

Look inside the AppDelegate.m for code to set the calendar view to the current window.

## Customisation

There are a few spots to go and modify the day cells and the calendar in general:
- Day / calendar view layout: look in the XIB (nibs)
- Colours: SDFCalendarOSXConstants.h
- Day selection: Look inside the SDFCalendarOSXDayViewController.m

## Other
- There are 2 asserts in the SDFCalendarOSXCalendarViewController.m that enforce the NSView the day views are inserted into conform to the grid size. What this means is that if the grid is 7 x 5 (x and y) then the width of the NSView for months has to be divisible by 7 exactly and the height by 5. This just keeps things sane.

## Enchancements

- Good autosizing of cells and month view
- Fluid layout

## Documentation

All documentation will be inside the source files.

## Issues

If you find anything wrong, please don't go and fork the project. Just add an issue and I'll take a look at fixing it. If you fix it yourself, awesome. Push it and let all of us enjoy the fix.