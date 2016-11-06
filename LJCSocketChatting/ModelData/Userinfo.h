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
@property (nonatomic,copy) NSString *userinfoTruename;
@property (nonatomic,copy) NSString *userinfoAddress;
@property (nonatomic,copy) NSString *userinfoSex;//性别
@property (nonatomic,copy) NSString *userinfoSexual;//性向
@property (nonatomic,copy) NSString *userinfoFeeling;//是否已婚
@property (nonatomic,copy) NSString *userinfoBirthday;
@property (nonatomic,copy) NSString *userinfoBloodtype;
@property (nonatomic,copy) NSString *userinfoBlogurl;
@property (nonatomic,copy) NSString *userinfoRealname;
@property (nonatomic,copy) NSString *userinfoIntro;
@property (nonatomic,copy) NSString *userinfoEmail;
@property (nonatomic,copy) NSString *userinfoQqnumber;
@property (nonatomic,copy) NSString *userinfoMessenger;//MSN
@property (nonatomic,copy) NSString *userinfoProfession;//职业
@property (nonatomic,copy) NSString *userinfoLabel;//标签
@property (nonatomic,copy) NSString *users;//对应用户ID


@end
