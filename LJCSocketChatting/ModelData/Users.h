//
//  Users.h
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Userinfo;
@class Messages;

@interface Users : NSObject

@property (nonatomic,assign) NSUInteger usersId;
@property (nonatomic,copy) NSString *usersEmail;
@property (nonatomic,copy) NSString *usersNikename;
@property (nonatomic,strong) NSDateFormatter *usersTime;
@property (nonatomic,assign) NSInteger *usersStatus;
@property (nonatomic,strong) NSArray<NSDictionary *> *userinfos;
@property (nonatomic,strong) NSArray<Messages *> *messageses;
@property (nonatomic,strong) NSArray *pictureses;
@property (nonatomic,strong) NSArray *collectionses;
@property (nonatomic,strong) NSArray *commentses;
@property (nonatomic,strong) NSURL *avatarImageURL;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
