#import "AppDelegate.h"
#import "PRGStationCoordinator.h"
#import "PRGUser.h"

@interface AppDelegate ()

@property (nonatomic, strong) PRGStationCoordinator *stationCoordinator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.stationCoordinator = [[PRGStationCoordinator alloc] init];
    [self.stationCoordinator initializePairingView];
    
    [self.stationCoordinator showPairingOverlay];
}

@end
