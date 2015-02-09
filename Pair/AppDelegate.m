#import "AppDelegate.h"
#import "PGRStationCoordinator.h"
#import "PRGUser.h"

@interface AppDelegate ()

@property (nonatomic, strong) PGRStationCoordinator *stationCoordinator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.stationCoordinator = [[PGRStationCoordinator alloc] init];
    [self.stationCoordinator initializePairingView];
    
    [self setupTestUsers];
    [self.stationCoordinator showPairingOverlay];
}

- (void)setupTestUsers {
    
    PRGUser *chrisUser = [[PRGUser alloc] init];
    chrisUser.name = @"Christopop";
    chrisUser.email = @"chris@usebutton.com";
    [self.stationCoordinator setLeftUser:chrisUser];
    
    PRGUser *wesUser = [[PRGUser alloc] init];
    wesUser.name = @"Wes Smith";
    wesUser.email = @"wes@usebutton.com";
    [self.stationCoordinator setRightUser:wesUser];
}

@end
