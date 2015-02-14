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
    //[self setupTestUsers];
}

- (void)setupTestUsers {
    
    PRGUser *chrisUser = [[PRGUser alloc] init];
    chrisUser.name = @"chrismaddern";
    [self.stationCoordinator setLeftUser:chrisUser];
    
    PRGUser *wesUser = [[PRGUser alloc] init];
    wesUser.name = @"wessmith";
    [self.stationCoordinator setRightUser:wesUser];
}

@end
