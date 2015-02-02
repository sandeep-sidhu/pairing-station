//
//  AppDelegate.m
//  Pair
//
//  Created by Chris Maddern on 2/2/15.
//  Copyright (c) 2015 Button. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

BOOL waitingToShow = NO;
NSWindow *trackingWin;

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    trackingWin=[[NSWindow alloc]
                 // NOTE: The coordinates of NSWindow are anchored at the bottom left
                 initWithContentRect:NSMakeRect(10,950,2000,100)
                 styleMask:NSBorderlessWindowMask
                 backing:NSBackingStoreBuffered
                 defer:YES];
    [trackingWin setOpaque:NO];
    [trackingWin setBackgroundColor:[NSColor clearColor]];
    [trackingWin setAlphaValue:0];
    [trackingWin setHasShadow:NO];
    [trackingWin setLevel:NSFloatingWindowLevel];
    [trackingWin setIgnoresMouseEvents:YES];
    [trackingWin orderFront:self];
    
    [[trackingWin contentView] layer].backgroundColor = [NSColor colorWithWhite:0 alpha:0.0].CGColor;
    [trackingWin makeKeyAndOrderFront:self];
    
    // Tracking areas need to be setup to handle when the mouse moves into or out of the main window
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(0, 0, 1950, 100)
                                                                options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways
                                                                  owner:self
                                                               userInfo:nil];
    
    [[trackingWin contentView] addTrackingArea:trackingArea];
    
    NSArray *arrayOfViews;
    [[NSBundle mainBundle] loadNibNamed:@"PRGUserViewLeft" owner:nil topLevelObjects:&arrayOfViews];
    
    for (id obj in arrayOfViews) {
        if ([obj isKindOfClass:[NSView class]]) {
            [trackingWin.contentView addSubview:obj];
        }
    }
    
    
    [[NSBundle mainBundle] loadNibNamed:@"PRGUserViewRight" owner:nil topLevelObjects:&arrayOfViews];
    
    for (id obj in arrayOfViews) {
        if ([obj isKindOfClass:[NSView class]]) {
            [trackingWin.contentView addSubview:obj];
            ((NSView *)obj).frame = NSMakeRect(1600, 0, 300, 110);
        }
    }
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    waitingToShow = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!waitingToShow) {
            return;
        }
        // Use Core Animation to fade in both windows.
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            [[trackingWin animator] setAlphaValue:1.0];
            [trackingWin setIgnoresMouseEvents:NO];
            
        } completionHandler:^{
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }];
    });
    
}

// If the mouse exits a window, go make sure we fade out
- (void)mouseExited:(NSEvent *)theEvent
{
    waitingToShow = NO;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        
        [[trackingWin animator] setAlphaValue:0];
        [trackingWin setIgnoresMouseEvents:YES];
        
    } completionHandler:^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}

@end
