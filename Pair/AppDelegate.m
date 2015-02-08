#import "AppDelegate.h"
#import "PRGDisplayCoordinator.h"
#import "PRGUser.h"

@interface AppDelegate ()

@property (nonatomic, strong) PRGDisplayCoordinator *overlayDisplayCoordinator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.overlayDisplayCoordinator = [[PRGDisplayCoordinator alloc] init];
    [self.overlayDisplayCoordinator initializePairingView];
    
    [self setupTestUsers];
}

- (void)setupTestUsers {
    
    PRGUser *chrisUser = [[PRGUser alloc] init];
    chrisUser.name = @"Christopop";
    chrisUser.email = @"chris@usebutton.com";
    [self.overlayDisplayCoordinator setLeftUser:chrisUser];
    
    PRGUser *wesUser = [[PRGUser alloc] init];
    wesUser.name = @"Wes Smith";
    wesUser.email = @"wes@usebutton.com";
    [self.overlayDisplayCoordinator setRightUser:wesUser];
}

@end
