//
//  RequestGenerator.m
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-24.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//

#import "RequestGenerator.h"
#import "UserManager.h"
#import "Users.h"
#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>



#define kTimeoutInterval 12.0f

@implementation RequestGenerator
//MD5加密
//+ (NSString *)md5HexDigest:(NSString*)input
//{
//    const char* str = [input UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, strlen(str), result);
//    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
//    
//    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
//        [ret appendFormat:@"%2x",result];
//    }
//    return ret;
//}

+ (NSString*)md5HexDigest:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

//用户登录
+ (NSURLRequest *)loginRequest: (NSString *)phoneNumStr andPass:(NSString *)passStr{
    NSString *md5Pwd = [self md5HexDigest:passStr];
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                  URLString:kLoginWithTel
                                                 parameters:@{@"telnum":phoneNumStr,@"password":md5Pwd}
                                                      error:nil];
    
}

//注册
+ (NSURLRequest *)registerRequestWithNickName:(NSString *)nickName andPhoneNum: (NSString *)phoneNumStr andPass:(NSString *)passStr andVerCode:(NSString *)verCode{
    NSString *md5Pwd = [self md5HexDigest:passStr];
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                  URLString:kRegistUser
                                        parameters:@{@"telnum":phoneNumStr,
                                                     @"password":md5Pwd,
                                                     @"nickname":nickName,
                                                     @"code":verCode}
                                                      error:nil];
}

+(NSURLRequest *)userInfoChangeRequest:(NSString *)urlStr{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = kTimeoutInterval;
    return request;
}


//获取用户信息
//+ (NSURLRequest *)userInfoRequest: (NSString *)uidStr {
//
//    NSUInteger index = [SeverURL indexOfString:@"appInterface"];
//    NSString *url = [SeverURL substringToIndex:index];
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@Getmember&uid=%@", url, uidStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    
//    [request setHTTPMethod:@"GET"];//POST
//    request.timeoutInterval = kTimeoutInterval;
//    return request;
//}
//发送注册验证码
+ (NSURLRequest *)sendVerifyCodeRequest:(NSString *)phoneNum
{
    NSString *urlStr =
    [NSString stringWithFormat:@"%@getSmsForReg?telnum=%@", SeverURL,phoneNum];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = kTimeoutInterval;
    return request;
}
//重置密码
+(NSURLRequest *)resetPasswordRequest:(NSString *)phoneNumStr andPass:(NSString *)passStr andVerCode:(NSString *)verCode{
    NSString *md5Pwd = [self md5HexDigest:passStr];
    NSString *urlStr = [NSString stringWithFormat:@"%@resetPwd?telnum=%@&password=%@&code=%@", SeverURL,phoneNumStr,md5Pwd,verCode];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];//POST
    request.timeoutInterval = kTimeoutInterval;
    return request;
}
//修改密码
+(NSURLRequest *)changePasswordRequest:(NSString *)userName andNewPwd:(NSString *)newPassword andOldPwd:(NSString *)oldPassword{
    if (!userName) {
        userName = @"";
    }
    if (!newPassword) {
        newPassword = @"";
    }else{
        newPassword = [self md5HexDigest:newPassword];
    }
    if (!oldPassword) {
        oldPassword = @"";
    }else{
        oldPassword = [self md5HexDigest:oldPassword];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@modifyPwd?telnum=%@&oldPwd=%@&newPwd=%@",SeverURL,userName,oldPassword,newPassword];
    return [self userInfoChangeRequest:urlStr];
}

//修改昵称(URL要修改)
+(NSURLRequest *)changeNickName:(NSString *)nickName{
    NSString *telnum = [[UserManager sharedInstance] loginedUser].usersEmail;
    //NSString *urlStr = [[NSString stringWithFormat:@"%@modifyNick?telnum=%@&nickname=%@",SeverURL,telnum,nickName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *urlStr = [[NSString stringWithFormat:@"%@modifyNick?telnum=%@&nickname=%@",SeverURL,telnum,nickName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *tempRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [tempRequest setHTTPMethod:@"GET"];
    tempRequest.timeoutInterval = kTimeoutInterval;
    return tempRequest;
}


//搜索用户
+(NSURLRequest *)searchUsers:(NSDictionary *)params{
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                  URLString:kSearchUser
                                                 parameters:params
                                                      error:nil];
}


//上传头像
+ (NSURLRequest *)UpdateImageRequest:(NSString *)imagePath andImgType:(NSInteger)type andRegistTel:(NSString *)registTel{
    Users *user = [[UserManager sharedInstance] loginedUser];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
//    NSString *urlStr = [NSString stringWithFormat:@"%@Editavatar&uid=%@&avatar=%@", kServerUrl, [UserInfoManager sharedInstance].loginedUser.uid, data];
    NSString *urlStr;
    if (user) {
        urlStr = [NSString stringWithFormat:@"%@uploadImg?telnum=%@&type=%d", SeverURL, user.usersEmail,(int)type];
    }else{
        urlStr = [NSString stringWithFormat:@"%@uploadImg?telnum=%@&type=%d", SeverURL, registTel,(int)type];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    //发送图片一定要注意格式
    NSString *boundary = @"---------------------------14737809831466499882746641449";//边界
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *temp = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"imgFile\"; filename=\"%@.png\"\r\n",user.usersEmail];
    [body appendData:[[NSString stringWithString:temp] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    [request setHTTPMethod:@"POST"];//POST
    request.timeoutInterval = kTimeoutInterval;
    return request;
}

/**
 *  工具函数，合并key=value
 *
 *  @param keyValues 参数集合
 *
 *  @return 字符串
 */
+(NSString*)dicToBody:(NSDictionary<__kindof NSString*,__kindof NSString*>*)keyValues {
 
    NSMutableString *body = [NSMutableString new];
    NSArray *keys = [keyValues allKeys];
    for (NSUInteger i=0; i<[keys count]; ++i) {
        NSString *k = keys[i];
        NSString *v = [keyValues objectForKey:k];
        [body appendString:k];
        [body appendFormat:@"=%@&", v];
    }

    if ([body length] > 0) {
        NSRange r = NSMakeRange([body length] - 1,1);
        [body deleteCharactersInRange:r];
    }
    return body;
}


//获取关注列表
+(NSURLRequest *)getFocusList:(NSString *)telnum{
//    NSString *urlStr = [NSString stringWithFormat:@"%@getMyFollowCp?telnum=%@",SeverURL,telnum];
//    NSMutableURLRequest *tempRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    NSLog(@"%@",urlStr);
//    [tempRequest setHTTPMethod:@"GET"];
//    tempRequest.timeoutInterval = kTimeoutInterval;
//    return tempRequest;
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                  URLString:kGetMyFollowCp
                                                 parameters:@{@"telnum":telnum}
                                                      error:nil];
}

//变更我的关注
+(NSURLRequest *)updateFocusList:(NSDictionary *)concernDict{
//    NSString *urlStr = [[NSString stringWithFormat:@"%@updateMyFollowCp?telnum=%@&cpRegno=%@&cpName=%@&cpCorporation=%@&flag=%@",SeverURL,concernDict[@"telnum"],concernDict[@"cpRegno"],concernDict[@"cpName"],concernDict[@"cpCorporation"],concernDict[@"flag"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *tempRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    [tempRequest setHTTPMethod:@"GET"];
//    tempRequest.timeoutInterval = kTimeoutInterval;
//    return tempRequest;
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                  URLString:kUpdateMyFollowCp
                                                 parameters:concernDict
                                                      error:nil];
}


//获取新微博
+(NSURLRequest *)queryMessages:(NSDictionary *)params{
    NSMutableURLRequest *request =
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                URLString:kQueryMessages
            parameters:params
                error:nil];
    return request;
}

//发新微博
+(NSURLRequest *)sendNewMessages:(NSDictionary *)params{
    return
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                         URLString:kSendMessages
                                                        parameters:params
                                                             error:nil];
}

//发送新微博


+(NSURLRequest*)generalRequest:(NSString*)url
                       dicBody:(NSDictionary*)dicBody {
    NSMutableURLRequest *request =
    [[AFHTTPRequestSerializer serializer]
     requestWithMethod:@"POST"
     URLString:url parameters:dicBody error:nil];
    request.timeoutInterval = kTimeoutInterval;
    return request;
}

//NSString *exampleStr = @" My name    is Johnny!";
//exampleStr = [exampleStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//NSArray *exampleArr = [exampleStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self <> ''"];
//exampleArr = [exampleArr filteredArrayUsingPredicate:predicate];
//exampleStr = [exampleArr componentsJoinedByString:@" "];
@end
