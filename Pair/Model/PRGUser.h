#import <Foundation/Foundation.h>

@interface PRGUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;


- (NSString *)imageUrlPath;

@end
