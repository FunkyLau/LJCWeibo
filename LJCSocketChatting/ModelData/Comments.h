//
//  Comments.h
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

@class Messages;
@class Users;
#import <Foundation/Foundation.h>

@interface Comments : NSObject
@property(nonatomic,assign)NSUInteger commentsId;
@property(nonatomic,strong)Messages *message;
@property(nonatomic,strong)Users *user;
@property(nonatomic,copy)NSString *commentsInfo;
@property(nonatomic,assign)NSInteger commentsInfoStatus;
@property(nonatomic,copy)NSString *commentsTime;
@end
