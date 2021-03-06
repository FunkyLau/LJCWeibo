//
//  UserManager.m
//  CreditDemand
//
//  Created by jiachen lau on 15/7/15.
//  Copyright (c) 2015年 yujiuyin. All rights reserved.
//

#import "UserManager.h"
#import "RequestGenerator.h"
#import "AFURLSessionManager.h"
#import "Users.h"
#import "Userinfo.h"

@implementation UserManager
@synthesize loginedUser = _loginedUser;


+ (UserManager *)sharedInstance
{
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [UserManager new];
        sharedInstance.afManager = [AFHTTPSessionManager manager];
//        [sharedInstance performSelector:@selector(deserializeUserInfo) afterDelay:0.1f];
        sharedInstance.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 自动登录
        
    });
    return sharedInstance;
}

/**
 * 反序列化用户信息,主要是MyProductManager 中使用的KVO机制。
 */
//-(void)deserializeUserInfo {
//    
//   self.loginedUser =
//    [EzJsonParser deserializeFromJson:[NSString stringWithContentsOfFile:[PathUtil pathOfUserInfo] encoding:NSUTF8StringEncoding error:nil] AsType:[UserInfo class]];
//}

/**
 *  自动登录
 */
-(void)autoLogin {
    if (![AppSettings boolForKey:BookKey_AutoLogin]) {
        return;
    }
    
    NSString *userName = [AppSettings stringForKey:StringKey_UserName];
    NSString *password = [AppSettings stringForKey:StringKey_Password];
    if (!userName || !password ||
        [userName isEmptyOrBlank] ||
        [password isEmptyOrBlank]) {
        return;
    }
    
    // 登录
    [self userLogin:userName
           password:password
withCompletionHandler:^(BOOL succeeded, NSDictionary *dicData) {
    if (succeeded) {
        NSLog(@"自动登录成功");
    }else{
        
    }
}];

}

- (Users *)loginedUser
{
    NSString *userFileStr = [PathUtil pathOfUserInfo];
    NSString *userJSONStr = [[NSString alloc] initWithContentsOfFile:userFileStr encoding:NSUTF8StringEncoding error:nil];
    Users *localUser = [Users modelWithJSON:userJSONStr];
    
    if (_loginedUser && ![_loginedUser.usersEmail isEmptyOrBlank]) {
        return _loginedUser;
    }
    return _loginedUser = localUser;;
}

// 是否登录
- (BOOL)isLogined{
    return ([self loginedUser] != nil);
}
//注册
-(void)userRegistWithNickName:(NSString *)nickName andPhoneNum:(NSString *)phoneNum andPass:(NSString *)passStr andVerCode:(NSString *)verCode andCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dictData))handler
{
    
    NSURLRequest *request=[RequestGenerator registerRequestWithNickName:nickName andPhoneNum:phoneNum andPass:passStr andVerCode:verCode];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, NSData *_Nullable responseObject, NSError * _Nullable error) {
        //[PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dictData = [responseStr jsonValueDecoded];
        if (error) {
            DJLog(@"Error: %@", error);
            handler(sucess,dictData);
        }else{
            sucess = YES;
            handler(sucess, dictData);
        }
        
    }];
    [dataTask resume];
}

-(void)userResetPassword:(NSString *)phoneNum andPass:(NSString *)passStr andVerCode:(NSString *)verCode andCompletionHandler:(void(^)(BOOL succeeded, NSString *response))handler{
    NSURLRequest *request=[RequestGenerator resetPasswordRequest:phoneNum andPass:passStr andVerCode:verCode];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        NSString *responseStr = nil;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess, responseStr);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,responseStr);
            }
        }
    }];
    [dataTask resume];
}


-(void)sendVerCode:(NSString *)phoneNum andCompletionHandler:(void(^)(BOOL succeeded, NSString *response))handler
{
    NSURLRequest *request = [RequestGenerator sendVerifyCodeRequest:phoneNum];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        NSString *responseStr = nil;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess, responseStr);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,responseStr);
            }
            
        }
        
    }];
    [dataTask resume];
}


-(void)savePathOfUserInfo
{
    NSString *str = [PathUtil pathOfUserInfo];
    NSLog(@"%@",str);
    NSString *modelStr = [_loginedUser modelToJSONString];
    if ([modelStr writeToFile:str atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"success");
    }else{
        NSLog(@"failed");
    }
}

- (void)removeUserInfo:(void(^)(BOOL))result
{
    [FileUtil deleteContentsOfDir:[PathUtil rootPathOfUser] withCompletionHandler:^(BOOL succeeded) {
        if (succeeded) {
            self.loginedUser = nil;
        }
        if (result != nil) {
            result(succeeded);
        }
    }];
}

-(void)userLogin:(NSString *)phoneNum password:(NSString *)password withCompletionHandler:(void(^)(BOOL succeeded, NSDictionary *dicData))handler{
    
    NSURLRequest *request=[RequestGenerator loginRequest:phoneNum andPass:password];
    //NSMutableArray* array = @[].mutableCopy;
    
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, NSData *_Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        NSDictionary *dicData = nil;
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (error) {
            //handler(sucess,dicData);
            DJLog(@"Error: %@", error);
        }else{
            dicData = [responseStr jsonValueDecoded];
            NSDictionary *resultDict = dicData[@"result"];
            // 保存用户名和密码
            if ([resultDict[@"resCode"] isEqualToString:@"0"]) {
                //登陆成功
                sucess=YES;
                Users *user = [Users modelWithDictionary:dicData[@"object"]];
                
                self.loginedUser = user;
                [AppSettings setString:phoneNum
                                forKey:StringKey_UserName];
                [AppSettings setString:password
                                forKey:StringKey_Password];
                //将用户信息写入文件
                [[UserManager sharedInstance] savePathOfUserInfo];
                if(handler){
                    handler(sucess, dicData);
                }
            }else{
                sucess = NO;
                if (handler) {
                    handler(sucess,dicData);
                }
            }
            
            //[PhoneNotification autoHideWithText:@"密码错误"];
            //[PhoneNotification autoHideWithText:@"用户不存在"];
        }
    }];
    [dataTask resume];
}

//搜索用户
-(void)searchUsers:(NSString *)nickName ifSucceed:(void(^)(BOOL succeed,NSArray *searchUsersArr))handler{
    Users * user = [self loginedUser];
    if (!user) {
        [PhoneNotification autoHideWithText:@"请先登录"];
        handler(NO,nil);
        return;
    }
    NSURLRequest *request = [RequestGenerator searchUsers:@{@"userId":[NSString stringWithFormat:@"%lu",(unsigned long)user.usersId],@"nickName":nickName}];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        NSMutableArray *searchUsersArr = [NSMutableArray array];
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            //NSDictionary *dic = [responseObject modelToJSONObject];
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [responseStr jsonValueDecoded];
            NSDictionary *dicData = dic[@"object"];
            NSArray *tempArr = dicData[@"showUsersInfo"];
            for (NSDictionary *tempDict in tempArr) {
                Users *user = [[Users alloc] init];
                user.usersNikename = tempDict[@"sUsersNikeName"];
                user.usersId = [tempDict[@"sUsersId"] integerValue];
                NSString *picUrl = tempDict[@"sUsersHeadPicUrl"];
                if (!picUrl) {
                    picUrl = @"";
                }
                NSArray *headPics = @[picUrl];
                user.pictureses = headPics;
                //user.userinfos
                [searchUsersArr addObject:user];
            }
            
            
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess,searchUsersArr);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,searchUsersArr);
            }
            
        }
    }];
    [dataTask resume];
}


//更改密码
-(void)changePasswordWithOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)newPwd ifSucceed:(void(^)(BOOL))handler
{
    //BOOL hasChanged = YES;
    //BOOL noChange = NO;
    Users * user = [self loginedUser];
    //    int id_id = loginedUser.id_id;
    NSURLRequest * request = [RequestGenerator changePasswordRequest:user.usersEmail andNewPwd:newPwd andOldPwd:oldPwd];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess);
            }
            
        }
        
    }];
    [dataTask resume];
}

//填写用户资料
-(void)userProfileWithUserInfo:(Userinfo *)userInfo ifSucceed:(void(^)(BOOL succeed,NSString *responseStr))handler{
    NSDictionary *params = @{@"userId":userInfo.usersId,@"userName":userInfo.userinfoRealname,@"introStr":userInfo.userinfoIntro,@"addrStr":userInfo.userinfoAddress,@"birthDate":userInfo.userinfoBirthday};
    NSURLRequest *request = [RequestGenerator userProfileRequest:params];
    NSURLSessionTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, NSData * _Nullable responseObject, NSError * _Nullable error) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [response jsonValueDecoded];
            NSDictionary *responseDict = dic[@"result"];
            NSString *responseStr = responseDict[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess,responseStr);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,responseStr);
            }
        }
    }];
    [dataTask resume];
}

//修改昵称
-(void)changeNickName:(NSString *)nickName ifSucceed:(void(^)(BOOL succeed))handler{
    NSURLRequest *request = [RequestGenerator changeNickName:nickName];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess);
            }
        }
        
    }];
    [dataTask resume];
}

//保存图片到本地(参数imageName其实为path)
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    [imageData writeToFile:imageName atomically:NO];
}


//上传头像1
-(void)uploadHeadPic:(NSString *)imagePath ifSucceed:(void(^)(BOOL succeed, NSDictionary *dicData))handler{
    NSURLRequest *request = [RequestGenerator UpdateImageRequest:imagePath];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess,dic);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess,dic);
            }
        }
        
    }];
    [dataTask resume];
}
/*
//提交反馈
-(void)submitFeedback:(NSString *)content andImgUrl:(NSString *)imgUrl andPhoneNum:(NSString *)phone ifSucceed:(void(^)(BOOL succeed))handler{
    NSURLRequest *request = [RequestGenerator userFeedbackWithContent:content andImgUrl:imgUrl andPhoneNum:phone];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [PhoneNotification hideNotification];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        BOOL sucess = NO;
        if (error) {
            DJLog(@"Error: %@", error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            response = dic[@"resDesc"];
            NSUInteger retCode = [[dic objectForKey:@"resCode"] integerValue] ;
            if (retCode == 0) {
                sucess = YES;
                handler(sucess);
            }else{
                //sucess = NO;
                DJLog(@"失败");
                handler(sucess);
            }
        }
        
    }];
    [dataTask resume];
}

*/
//获取banner图片
/*
-(void)getBannerPicturesIfSucceed:(void(^)(BOOL succeed,NSArray *result))handler{
    
    NSURLRequest *req = [RequestGenerator bannerPictures];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            DJLog(@"Error:%@",error);
        }else{
            BOOL succeed = NO;
            NSArray *result = nil;
            NSDictionary *dic = [responseObject modelToJSONObject];
            result = dic[@"result"];
            if ([[dic valueForKey:@"resCode"] isEqualToString:@"0"]) {
                succeed = YES;
            }
            if (handler) {
                handler(succeed,result);
            }
        }
    }];
    [dataTask resume];
}
*/
//获取我的关注列表
-(void)getFocusList:(NSString *)telnum ifSucceed:(void(^)(BOOL succeed,NSArray *result))handler{
    NSURLRequest *req = [RequestGenerator getFocusList:telnum];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            handler(NO,nil);
            DJLog(@"Error: %@",error);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            NSArray *result;
            if ([dic[@"result"] isKindOfClass:[NSNull class]]) {
                result = [NSArray array];
            }else{
                result = dic[@"result"];
            }
            
            if ([[dic valueForKey:@"resCode"] isEqualToString:@"0"]) {
                handler(YES,result);
            }else{
                handler(NO,result);
            }
        }
    }];
    [dataTask resume];
}

//变更我的关注
-(void)updateFocusList:(NSDictionary *)concernDict ifSucceed:(void(^)(BOOL succeed,NSString *result))handler{
    //(NSString *)telnum andCpName:(NSString *)cpName andCpCorporation:(NSString *)cpCorporation andFlag:(NSString *)flag
    NSURLRequest *req = [RequestGenerator updateFocusList:concernDict];
    NSURLSessionDataTask *dataTask = [_afManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            
            DJLog(@"Error: %@",error);
            handler(NO,nil);
        }else{
            NSDictionary *dic = [responseObject modelToJSONObject];
            NSString *result = dic[@"result"];
            
            if ([[dic valueForKey:@"resCode"] isEqualToString:@"0"]) {
                handler(YES,result);
            }else{
                handler(NO,result);
            }
        }
    }];
    [dataTask resume];
}

@end
