//
//  MessageManager.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/11/3.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Messages;

@interface MessageManager : NSObject

//@property (nonatomic,strong) Messages *message;
@property(nonatomic,strong)AFURLSessionManager *afManager;

+ (MessageManager *)sharedInstance;
//发送微博
- (void)sendMessageWithUserId:(NSString *)userId andMessageInfo:(NSString *)messageInfo andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *messagesDict))handler;
//获取新微博
- (void)queryNewMessageWithUserId:(NSString *)userId andFromIndex:(NSString *)from andCompletionHandler:(void(^)(BOOL succeeded, NSArray *messages))handler;
//保存图片到本地(参数imageName其实为path)
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

//发送微博图片
- (void)uploadWeiboPicturesWithMessageId:(NSString *)messagesId andImageName:(NSString *)imageName andImagePath:(NSString *)imagePath andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dicData))handler;
@end
