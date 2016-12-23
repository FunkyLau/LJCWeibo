//
//  Userinfo.h
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Userinfo : NSObject

@property (nonatomic,copy) NSString *userinfoId;
@property (nonatomic,copy) NSString *userinfoTruename; //真实姓名 *
@property (nonatomic,copy) NSString *userinfoAddress; //地址 *（有默认）
@property (nonatomic,copy) NSString *userinfoSex;//性别 *
@property (nonatomic,copy) NSString *userinfoSexual;//性向
@property (nonatomic,copy) NSString *userinfoFeeling;//是否已婚
@property (nonatomic,copy) NSString *userinfoBirthday; //生日 *
@property (nonatomic,copy) NSString *userinfoBloodtype; //血型
@property (nonatomic,copy) NSString *userinfoBlogurl; //博客地址
@property (nonatomic,copy) NSString *userinfoRealname; //
@property (nonatomic,copy) NSString *userinfoIntro;  //一句话简介 *
@property (nonatomic,copy) NSString *userinfoEmail;  //email地址
@property (nonatomic,copy) NSString *userinfoQqnumber; //QQ号
@property (nonatomic,copy) NSString *userinfoMessenger;//MSN
@property (nonatomic,copy) NSString *userinfoProfession;//职业
@property (nonatomic,copy) NSString *userinfoLabel;//标签
@property (nonatomic,copy) NSString *usersId;//对应用户ID


@end
