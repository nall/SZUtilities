//
//  SZOverlayWindow.h
//  SZUtilities
//
//  Created by Jon Nall on 11/01/09.
//  Copyright (c) 2009 STUNTAZ!!!. All rights reserved.
//  
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation 
//  and/or other materials provided with the distribution.
//  
//  Neither the name of Jon Nall  nor the names of its contributors may be used 
//  to endorse or promote products derived from this software without specific 
//  prior written permission. 
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.

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
