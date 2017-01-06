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
#import "MJRefresh.h"

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

- (void)sendMessageWithUserId:(NSString *)userId andMessageInfo:(NSString *)messageInfo andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *messagesDict))handler{
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
        NSDictionary *responseDict = [responseStr jsonValueDecoded];
        NSDictionary *messagesDict = responseDict[@"object"];
        if (error) {
            DJLog(@"Error: %@", error);
            
            handler(success,messagesDict);
        }else{
            success = YES;            
            handler(success, messagesDict);
        }
    }];
    [task resume];
}
- (void)queryNewMessageWithUserId:(NSString *)userId andFromIndex:(NSString *)from andCompletionHandler:(void(^)(BOOL succeeded, NSArray *messages))handler{
    NSDictionary *params = @{@"usersId":userId,@"from":from};
    NSURLRequest *request = [RequestGenerator queryMessages:params];
    NSURLSessionTask *task = [_afManager dataTaskWithRequest:request
                                           completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
                              {
                                  [[NSURLCache sharedURLCache] removeAllCachedResponses];
                                  [[NSURLCache sharedURLCache] setDiskCapacity:0];
                                  [[NSURLCache sharedURLCache] setMemoryCapacity:0];
                                  BOOL success = NO;
                                  NSDictionary *dicData = nil;
                                  
                                  //NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                  if (error) {
                                      DJLog(@"Error: %@", error);
                                      [PhoneNotification autoHideWithText:@"网络异常，请检查网络"];
                                  }else{
                                      success = YES;
                                      dicData = [responseObject jsonValueDecoded];
                                      NSDictionary *tempDict = dicData[@"object"];
                                      NSArray *messagesArr = tempDict[@"messages"];
                                      handler(success, messagesArr);
                                  }
                              }];
    [task resume];
}

//发送微博图片
- (void)uploadWeiboPicturesWithMessageId:(NSString *)messagesId andImagePath:(NSString *)imagePath andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dicData))handler{
    NSURLRequest *request = [RequestGenerator upLoadWeiboImageRequest:imagePath andMessageId:messagesId];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [responseStr jsonValueDecoded];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess,dic);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,dic);
            }
        }
        
    }];
    [dataTask resume];
}

//保存图片到本地(参数imageName其实为path)
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    [imageData writeToFile:imageName atomically:NO];
}

@end
