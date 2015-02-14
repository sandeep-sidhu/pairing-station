#import "PRGGitHubAPI.h"

@implementation PRGGitHubAPI

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.github.com/"]];
        self.requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}


- (void)fetchUserWithName:(NSString *)username
               completion:(PRGGitHubUserFetchCompletion)completion {
    [self.requestManager GET:[NSString stringWithFormat:@"/users/%@", username] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject && completion) {
            completion(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil);
    }];
}

@end
