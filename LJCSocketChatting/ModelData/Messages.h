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
//@property (nonatomic, assign) NSUInteger postID;
@property (nonatomic, strong) NSString *messages_type;

@property (nonatomic, strong) NSString *messages_info;
@property (nonatomic, strong) NSString *messages_time;
@property (nonatomic, strong) NSString *messages_collectnum;
@property (nonatomic, strong) NSString *messages_commentnum;
@property (nonatomic, strong) NSString *messages_transpondnum;
@property (nonatomic, strong) NSString *messages_agreenum;
@property (nonatomic, strong) NSString *messages_readnum;
@property (nonatomic, strong) NSString *messages_label;
@property (nonatomic, strong) Users *users;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

//+ (NSURLSessionDataTask *)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;
@end
