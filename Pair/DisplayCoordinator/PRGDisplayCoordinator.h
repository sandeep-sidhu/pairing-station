@import AppKit;
@class PRGUserView, PRGUser;

@interface PRGDisplayCoordinator : NSObject

@property (nonatomic, strong) PRGUser *leftUser;
@property (nonatomic, strong) PRGUser *rightUser;

@property (nonatomic, strong) NSWindow *overlayWindow;

@property (nonatomic, strong) PRGUserView *leftUserOverlay;
@property (nonatomic, strong) PRGUserView *rightUserOverlay;

@property (nonatomic, strong) NSTrackingArea *leftTrackingArea;
@property (nonatomic, strong) NSTrackingArea *rightTrackingArea;

- (void)initializePairingView;

@end
