#import "PRGUserView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PRGUserView

- (void)awakeFromNib {
   [self setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
}


- (void)viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    self.image.layer.borderColor = [NSColor lightGrayColor].CGColor;
    self.image.layer.cornerRadius = 40;
    self.image.layer.borderWidth = 1;
    self.image.layer.masksToBounds = YES;
}
@end
