#import <Foundation/Foundation.h>

@interface PRGUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *imageUrl;


- (NSString *)imageUrlPath;

@end
