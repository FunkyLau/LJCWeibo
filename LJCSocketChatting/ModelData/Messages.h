//
//  Posts.h
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Users;
@interface Messages : NSObject
@property(nonatomic,copy)NSString *messagesId;
@property (nonatomic, copy) NSString *messagesType;
//@property (nonatomic, strong) NSString *messages_contentType;
@property (nonatomic, copy) NSString *messagesInfo;
@property (nonatomic, copy) NSString *messagesTime;
@property (nonatomic, copy) NSString *messagesCollectnum;
@property (nonatomic, copy) NSString *messagesCommentnum;
@property (nonatomic, copy) NSString *messagesTranspondnum;
@property (nonatomic, copy) NSString *messagesAgreenum;
@property (nonatomic, copy) NSString *messagesReadnum;
@property (nonatomic, copy) NSString *messagesLabel;
@property (nonatomic, strong) Users *users;
@property (nonatomic, strong) NSArray *pictureses;
@property (nonatomic, strong) NSArray *commentses;
@property (nonatomic, strong) NSArray *collectionses;
@property (nonatomic, strong) NSArray *atuserses;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;
@end
