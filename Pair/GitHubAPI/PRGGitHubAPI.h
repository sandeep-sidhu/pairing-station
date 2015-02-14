#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

typedef void(^PRGGitHubUserFetchCompletion)(NSDictionary *userDict);

@interface PRGGitHubAPI : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

- (void)fetchUserWithName:(NSString *)username
               completion:(PRGGitHubUserFetchCompletion)completion;

@end
