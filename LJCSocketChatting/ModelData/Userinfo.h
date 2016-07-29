//
//  Userinfo.h
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Userinfo : NSObject

@property (nonatomic,copy) NSString *userinfo_id;
@property (nonatomic,copy) NSString *userinfo_truename;
@property (nonatomic,copy) NSString *userinfo_address;
@property (nonatomic,copy) NSString *userinfo_sex;//性别
@property (nonatomic,copy) NSString *userinfo_sexual;//性向
@property (nonatomic,copy) NSString *userinfo_feeling;//是否已婚
@property (nonatomic,copy) NSString *userinfo_birthday;
@property (nonatomic,copy) NSString *userinfo_bloodtype;
@property (nonatomic,copy) NSString *userinfo_blogurl;
@property (nonatomic,copy) NSString *userinfo_realname;
@property (nonatomic,copy) NSString *userinfo_intro;
@property (nonatomic,copy) NSString *userinfo_email;
@property (nonatomic,copy) NSString *userinfo_qqnumber;
@property (nonatomic,copy) NSString *userinfo_messenger;//MSN
@property (nonatomic,copy) NSString *userinfo_profession;//职业
@property (nonatomic,copy) NSString *userinfo_label;//标签
@property (nonatomic,assign) NSUInteger usersId;//对应用户ID


@end
