#import "PRGStationCoordinator.h"
#import "PRGUserView.h"
#import "PRGUser.h"

typedef NS_ENUM(NSInteger, PRGSeatSide) {
    PRGSeatSideLeft,
    PRGSeatSideRight
};

@implementation PRGStationCoordinator

BOOL waitingToShowOverlay = NO;

- (void)initializePairingView {
    NSScreen *mainScreen    = [NSScreen mainScreen];
    NSRect mainScreenBounds = mainScreen.frame;
    
    NSInteger overlayWidth   = 300;
    NSInteger overlayHeight  = 100;
    
    NSRect overlayBoundingRect = NSMakeRect(0, mainScreenBounds.size.height - 70, mainScreenBounds.size.width, overlayHeight);
    self.overlayWindow = [[NSWindow alloc] initWithContentRect:overlayBoundingRect
                                                     styleMask:NSBorderlessWindowMask
                                                       backing:NSBackingStoreBuffered
                                                         defer:YES];
    [self.overlayWindow setOpaque:NO];
    [self.overlayWindow setBackgroundColor:[NSColor clearColor]];
    [self.overlayWindow setAlphaValue:0];
    [self.overlayWindow setHasShadow:NO];
    [self.overlayWindow setLevel:NSFloatingWindowLevel];
    [self.overlayWindow setIgnoresMouseEvents:YES];
    [self.overlayWindow orderFront:self];
    
    [[self.overlayWindow contentView] layer].backgroundColor = [NSColor colorWithWhite:0 alpha:0.0].CGColor;
    [self.overlayWindow makeKeyAndOrderFront:self];
    
    self.leftTrackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(0, 0, overlayWidth, overlayHeight)
                                                         options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways
                                                           owner:self
                                                        userInfo:nil];
    
    [[self.overlayWindow contentView] addTrackingArea:self.leftTrackingArea];
    self.rightTrackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(mainScreenBounds.size.width - overlayWidth,
                                                                             0,
                                                                             overlayWidth,
                                                                             overlayHeight)
                                                          options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways
                                                            owner:self
                                                         userInfo:nil];
    
    [[self.overlayWindow contentView] addTrackingArea:self.rightTrackingArea];
    
    __weak PRGStationCoordinator *weakSelf = self;
    
    self.leftUserOverlay = [PRGUserView leftUserView];
    [self.leftUserOverlay setChangeUserHandler:^{
        [weakSelf promptForLoginOnSeatSide:PRGSeatSideLeft];
    }];
    [self.overlayWindow.contentView addSubview:self.leftUserOverlay];
    
    self.rightUserOverlay = [PRGUserView rightUserView];
    [self.rightUserOverlay setChangeUserHandler:^{
        [weakSelf promptForLoginOnSeatSide:PRGSeatSideRight];
    }];
    [self.overlayWindow.contentView addSubview:self.rightUserOverlay];
    self.rightUserOverlay.frame = NSMakeRect(mainScreenBounds.size.width - overlayWidth, 0, overlayWidth, 110);
}


- (void)promptForLoginOnSeatSide:(PRGSeatSide)seatSide {
    NSLog(@"Prompting for login on seatSide: %ld", seatSide);
}


- (void)mouseEntered:(NSEvent *)theEvent {
    waitingToShowOverlay = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!waitingToShowOverlay) {
            return;
        }
        [self showPairingOverlay];
    });
    
}


- (void)mouseExited:(NSEvent *)theEvent {
    waitingToShowOverlay = NO;
    [self hidePairingOverlay];
}


- (void)showPairingOverlay {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [[self.overlayWindow animator] setAlphaValue:1.0];
        [self.overlayWindow setIgnoresMouseEvents:NO];
        
    } completionHandler:^{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}


- (void)hidePairingOverlay {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        
        [[self.overlayWindow animator] setAlphaValue:0];
        [self.overlayWindow setIgnoresMouseEvents:YES];
        
    } completionHandler:^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}


- (void)setLeftUser:(PRGUser *)user {
    _leftUser = user;
    [self.leftUserOverlay setUser:user];
}


- (void)setRightUser:(PRGUser *)user {
    _rightUser = user;
    [self.rightUserOverlay setUser:user];
}

@end
