//
//  SZOverlayWindow.m
//  SZUtilities
//
//  Created by Jon Nall on 10/31/09.
//  Copyright 2009 STUNTAZ!!!. All rights reserved.
//

#import "SZOverlayWindow.h"

@interface SZOverlayWindow(Private)
-(void)updateFrame:(NSNotification*)notification;
@end

@implementation SZOverlayWindow

-(id)initWithParentWindow:(NSWindow*)parentWindow
                 withView:(NSView*)subview
{
    NSRect overlayRect = NSMakeRect(parentWindow.frame.origin.x,
                                    parentWindow.frame.origin.y, 
                                    [[parentWindow contentView] frame].size.width,
                                    [[parentWindow contentView] frame].size.height);
    
    self = [super initWithContentRect:overlayRect
                            styleMask:NSBorderlessWindowMask
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if(self != nil)
    {
        // Add the specified subview to our list of subviews
        [[self contentView] addSubview:subview];

        // We're translucent, so not opaque
        [self setOpaque:NO];

        // Set background to a translucent gray
        [self setBackgroundColor:[NSColor colorWithDeviceRed:0
                                                       green:0
                                                        blue:0
                                                       alpha:0.5]];
        // Start out as "hidden"
        [self setAlphaValue:0.0];

        // Add ourself to the parent
        [parentWindow addChildWindow:self
                             ordered:NSWindowAbove];  
        
        // Observe our parent window's resize and move notifications
        // so we can resize / move ourself appropriately
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateFrame:)
                                                     name:NSWindowDidMoveNotification
                                                   object:parentWindow];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateFrame:)
                                                     name:NSWindowDidResizeNotification
                                                   object:parentWindow];
    }
    
    return self;
}

// By default NSWindows cannot become key. We can.
-(BOOL)canBecomeKeyWindow
{
    return YES;
}

@end

@implementation SZOverlayWindow(Private)

// Callback for when our parent window moves or resizes.
// Just adjust ourselves to sit inside its contentView rect.
-(void)updateFrame:(NSNotification*)notification
{
    NSWindow* parentWindow = [self parentWindow];
    NSRect overlayRect = NSMakeRect(parentWindow.frame.origin.x,
                                    parentWindow.frame.origin.y, 
                                    [[parentWindow contentView] frame].size.width,
                                    [[parentWindow contentView] frame].size.height);
    [self setFrame:overlayRect
           display:YES];
}
@end
