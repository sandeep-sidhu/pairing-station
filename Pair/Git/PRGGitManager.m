#import "PRGGitManager.h"

@implementation PRGGitManager

- (void)setConfigUsername:(NSString *)name {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/git";
    task.arguments = @[@"config", @"--global", @"user.name", name];
    [task launch];
}

@end
