//
//  Posts.m
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import "Messages.h"
#import "Users.h"

@implementation Messages

-(instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
//    self.postID = (NSUInteger)[[attributes valueForKeyPath:@"messages.messagesId"] integerValue];
//    self.weiboContent = [attributes valueForKeyPath:@"messages.messagesInfo"];
//    self.users = [[Users alloc] initWithAttributes:[attributes valueForKeyPath:@"messages.users"]];
    
    return self;
}
#pragma mark -
/*
+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
    //return [[AFAppDotNetAPIClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:
    return [[AFAppDotNetAPIClient sharedClient] GET:@"/MessagesAction_queryMessages.action" parameters:nil  success:^(NSURLSessionDataTask * __unused task, id JSON) {
        //NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"showMessages.messages"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            Posts *posts = [[Posts alloc] initWithAttributes:attributes];
            [mutablePosts addObject:posts];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
            NSLog(@"ERROR");
        }
    }];
}
*/

@end
