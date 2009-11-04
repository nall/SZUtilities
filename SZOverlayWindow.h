//
//  SZOverlayWindow.h
//  SZUtilities
//
//  Created by Jon Nall on 10/31/09.
//  Copyright 2009 STUNTAZ!!!. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SZOverlayWindow : NSWindow
{
}
-(id)initWithParentWindow:(NSWindow*)parentWindow
                 withView:(NSView*)subview;
@end
