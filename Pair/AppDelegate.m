#import "AppDelegate.h"

BOOL waitingToShow = NO;
NSWindow *trackingWin;

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSScreen *mainScreen    = [NSScreen mainScreen];
    NSRect mainScreenBounds = mainScreen.frame;
    
    NSInteger pairingOverlayWidth   = 300;
    NSInteger pairingOverlayHeight  = 100;
    
    trackingWin=[[NSWindow alloc]
                 // NOTE: The coordinates of NSWindow are anchored at the bottom left
                 initWithContentRect:NSMakeRect(0, mainScreenBounds.size.height - 70, mainScreenBounds.size.width, pairingOverlayHeight)
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
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(0, 0, pairingOverlayWidth, pairingOverlayHeight)
                                                                options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways
                                                                  owner:self
                                                               userInfo:nil];
    
    [[trackingWin contentView] addTrackingArea:trackingArea];
    NSTrackingArea *trackingArea2 = [[NSTrackingArea alloc] initWithRect:NSMakeRect(mainScreenBounds.size.width - pairingOverlayWidth,
                                                                                    0,
                                                                                    pairingOverlayWidth,
                                                                                    pairingOverlayHeight)
                                                                options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways
                                                                  owner:self
                                                               userInfo:nil];
    
    [[trackingWin contentView] addTrackingArea:trackingArea2];
    
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
            ((NSView *)obj).frame = NSMakeRect(mainScreenBounds.size.width - pairingOverlayWidth, 0, pairingOverlayWidth, 110);
        }
    }
    
    
}


- (void)mouseEntered:(NSEvent *)theEvent {
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


- (void)mouseExited:(NSEvent *)theEvent {
    waitingToShow = NO;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        
        [[trackingWin animator] setAlphaValue:0];
        [trackingWin setIgnoresMouseEvents:YES];
        
    } completionHandler:^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}

@end
