#import "AppDelegate.h"
#import "PRGStationCoordinator.h"
#import "PRGUser.h"
@import AppKit;

@interface AppDelegate ()

@property (nonatomic, strong) PRGStationCoordinator *stationCoordinator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.stationCoordinator = [[PRGStationCoordinator alloc] init];
    [self.stationCoordinator initializePairingView];
    
    [self.stationCoordinator showPairingOverlay];
    [self configureToShowOnUnlock];
}


- (void)configureToShowOnUnlock {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(screenUnlocked:)
                                                            name:@"com.apple.sessionAgent.SessionSwitchReady"
                                                          object:nil];
}


- (void)screenUnlocked:(NSNotification *)notif {
    [self.stationCoordinator showPairingOverlay];
}

@end
