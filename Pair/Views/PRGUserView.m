@import QuartzCore;
#import "PRGUserView.h"
#import "PRGUser.h"
#import "NSImageView+AFNetworking.h"

@interface PRGUserView ()

@property (nonatomic, strong) IBOutlet NSTextField *nameLabel;
@property (nonatomic, strong) IBOutlet NSTextField *emailLabel;

@property (nonatomic, strong) IBOutlet NSImageView *imageView;

@end

@implementation PRGUserView

- (void)awakeFromNib {
   [self setWantsLayer:YES]; // required on NSView to use layer manipulation
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    [self.emailLabel setStringValue:@"Nobody.. yet"];
    [self.nameLabel setStringValue:@"Come pair!"];
    [self.imageView setImage:nil];
}


- (void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    self.imageView.layer.borderColor    = [NSColor lightGrayColor].CGColor;
    self.imageView.layer.cornerRadius   = 40;
    self.imageView.layer.borderWidth    = 1;
    self.imageView.layer.masksToBounds  = YES;
    
    self.layer.cornerRadius         = 5;
    self.layer.masksToBounds        = YES;
}


- (void)setUser:(PRGUser *)user {
    _user = user;
    
    [self.nameLabel setStringValue:user.name];
    [self.emailLabel setStringValue:user.email];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:[user imageUrlPath]]];
}

@end
