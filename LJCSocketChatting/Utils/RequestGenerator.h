//
//  RequestGenerator.h
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-24.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>



//@class PayForData;
//@class UserInfo;
@interface RequestGenerator : NSObject{
    
}

//登录
+ (NSURLRequest *)loginRequest: (NSString *)phoneNumStr andPass:(NSString *)passStr;

//注册
+ (NSURLRequest *)registerRequestWithNickName:(NSString *)nickName andPhoneNum: (NSString *)phoneNumStr andPass:(NSString *)passStr andVerCode:(NSString *)verCode;

+ (NSURLRequest *)sendVerifyCodeRequest:(NSString *)phoneNum;
//上传头像或问题报告
+ (NSURLRequest *)UpdateImageRequest:(NSString *)imagePath andImgType:(NSInteger)type andRegistTel:(NSString *)registTel;
//重置密码
+(NSURLRequest *)resetPasswordRequest:(NSString *)phoneNumStr andPass:(NSString *)passStr andVerCode:(NSString *)verCode;


//修改密码
+(NSURLRequest *)changePasswordRequest:(NSString *)userName andNewPwd:(NSString *)newPassword andOldPwd:(NSString *)oldPassword;

//用户实名认证
+ (NSURLRequest *)realNameQueryWithName:(NSDictionary *)realNameDict;
//修改昵称
+(NSURLRequest *)changeNickName:(NSString *)nickName;

//意见反馈
//+ (NSURLRequest *)userFeedbackWithContent:(NSString *)content andImgUrl:(NSString *)imgUrl andPhoneNum:(NSString *)phone;

//获取新微博
+(NSURLRequest *)queryMessages:(NSDictionary *)params;
//发新微博
+(NSURLRequest *)sendNewMessages:(NSDictionary *)params;

//获取banner
+(NSURLRequest *)bannerPictures;


//获取关注列表
+(NSURLRequest *)getFocusList:(NSString *)telnum;

//变更我的关注
+(NSURLRequest *)updateFocusList:(NSDictionary *)concernDict;

@end
