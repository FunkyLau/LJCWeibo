//
//  MessageManager.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/11/3.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "MessageManager.h"
#import "RequestGenerator.h"
#import "AFURLSessionManager.h"
#import "Messages.h"

@implementation MessageManager

+ (MessageManager *)sharedInstance{
    static MessageManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MessageManager new];
        sharedInstance.afManager = [AFHTTPSessionManager manager];
        sharedInstance.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return sharedInstance;
}

- (void)sendMessageWithUserId:(NSString *)userId andMessageInfo:(NSString *)messageInfo andCompletionHandler:(void(^)(BOOL succeeded, NSString *response))handler{
    if (!userId) {
        userId = @"";
    }
    if (!messageInfo) {
        NSLog(@"发送信息为空");
        return;
    }
    NSDictionary *params = @{@"usersId":userId,@"messagesInfo":messageInfo};
    NSURLRequest *request = [RequestGenerator sendNewMessages:params];
    NSURLSessionTask *task = [_afManager dataTaskWithRequest:request
                                           completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL success = NO;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (error) {
            DJLog(@"Error: %@", error);
            responseStr = @"failed";
            handler(success,responseStr);
        }else{
            success = YES;
            handler(success, responseStr);
        }
    }];
    [task resume];
}
- (void)queryNewMessageWithUserId:(NSString *)userId andCompletionHandler:(void(^)(BOOL succeeded, NSString *response))handler{
    NSDictionary *params = @{@"usersId":userId};
    NSURLRequest *request = [RequestGenerator queryMessages:params];
    NSURLSessionTask *task = [_afManager dataTaskWithRequest:request
                                           completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
                              {
                                  [[NSURLCache sharedURLCache] removeAllCachedResponses];
                                  [[NSURLCache sharedURLCache] setDiskCapacity:0];
                                  [[NSURLCache sharedURLCache] setMemoryCapacity:0];
                                  BOOL success = NO;
                                  NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                  if (error) {
                                      DJLog(@"Error: %@", error);
                                      responseStr = @"failed";
                                      handler(success,responseStr);
                                  }else{
                                      success = YES;
                                      handler(success, responseStr);
                                  }
                              }];
    [task resume];
}
@end
