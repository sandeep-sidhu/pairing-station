#import <Cocoa/Cocoa.h>
@class PRGUser;

@interface PRGUserView : NSView

@property (nonatomic, strong) PRGUser *user;

+ (PRGUserView *)leftUserView;
+ (PRGUserView *)rightUserView;

+ (PRGUserView *)userViewWithNibName:(NSString *)nibName;

@end
