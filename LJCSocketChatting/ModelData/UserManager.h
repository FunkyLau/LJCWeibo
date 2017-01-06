//
//  UserManager.h
//  CreditDemand
//
//  Created by yujiuyin on 15/7/15.
//  Copyright (c) 2015年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFURLSessionManager;
@class Users;
@class Userinfo;

@interface UserManager : NSObject

@property(nonatomic,strong)Users *loginedUser;
@property(nonatomic,strong)AFURLSessionManager *afManager;

+(UserManager *)sharedInstance;
- (Users *)loginedUser;

//自动登录
-(void)autoLogin;
// 是否登录
- (BOOL)isLogined;
- (void)savePathOfUserInfo;
- (void)removeUserInfo:(void(^)(BOOL))result;
//注册
- (void)userRegistWithNickName:(NSString *)nickName andPhoneNum:(NSString *)phoneNum andPass:(NSString *)passStr andVerCode:(NSString *)verCode andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dictData))handler;
//用户登录
-(void)userLogin:(NSString *)phoneNum password:(NSString *)password withCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dicData))handler;
//重置密码
-(void)userResetPassword:(NSString *)phoneNum andPass:(NSString *)passStr andVerCode:(NSString *)verCode andCompletionHandler:(void(^)(BOOL succeeded, NSString *response))handler;
//修改密码
-(void)changePasswordWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd ifSucceed:(void(^)(BOOL))handler;
//修改昵称
-(void)changeNickName:(NSString *)nickName ifSucceed:(void(^)(BOOL succeed))handler;

//搜索用户
-(void)searchUsers:(NSString *)nickName ifSucceed:(void(^)(BOOL succeed,NSArray *searchUsersArr))handler;
//填写用户资料
-(void)userProfileWithUserInfo:(Userinfo *)userInfo ifSucceed:(void(^)(BOOL succeed,NSString *responseStr))handler;
//保存头像和问题图片到本地
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
//上传头像
-(void)uploadHeadPic:(NSString *)imagePath ifSucceed:(void(^)(BOOL succeed, NSDictionary *dicData))handler;
//提交反馈
//-(void)submitFeedback:(NSString *)content andImgUrl:(NSString *)imgUrl andPhoneNum:(NSString *)phone ifSucceed:(void(^)(BOOL succeed))handler;

//获取banner图片
//-(void)getBannerPicturesIfSucceed:(void(^)(BOOL succeed,NSArray *result))handler;


//获取我的关注列表
-(void)getFocusList:(NSString *)telnum ifSucceed:(void(^)(BOOL succeed,NSArray *result))handler;

@end
