#import "PRGUserView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PRGUserView

- (void)awakeFromNib {
   [self setWantsLayer:YES]; // required on NSView to use layer manipulation
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
}


- (void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    self.image.layer.borderColor    = [NSColor lightGrayColor].CGColor;
    self.image.layer.cornerRadius   = 40;
    self.image.layer.borderWidth    = 1;
    self.image.layer.masksToBounds  = YES;
    
    self.layer.cornerRadius         = 5;
    self.layer.masksToBounds        = YES;
}

@end
