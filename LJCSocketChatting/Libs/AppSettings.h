//
//  AppSettings.h
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-23.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>


// 添加同类型的key ,如何有默认值，请来Get函数中添加默认值

#define BoolKey @"key0000"
#define BookKey_AutoLogin @"key0001"    // 自动登录(默认YES)


#define IntKey @"key0200"


#define FloatKey @"key0300"


#define DoubleKey @"key0400"



#define StringKey @"Key0500"
#define StringKey_First_Version @"Key0501" // 新版本第一次启动
#define StringKey_UserName @"Key0502"       // 用户名
#define StringKey_Password @"Key0503"       // 密码

#define DateKey @"key0600"



@interface AppSettings : NSObject


// 新增加的方法
+ (void)setInteger:(NSInteger)value forKey:(NSString *)keyName;
+ (void)setFloat:(float)value forKey:(NSString *)keyName;
+ (void)setDouble:(double)value forKey:(NSString *)keyName;
+ (void)setBool:(BOOL)value forKey:(NSString *)keyName;
+ (void)setString:(NSString *)value forKey:(NSString *)keyName;
+ (void)setURL:(NSURL *)value forKey:(NSString *)keyName;
+ (void)setDate:(NSDate*)value forkey:(NSString *)keyName;


+ (NSInteger)integerForKey:(NSString *)keyName;
+ (NSString *)stringForKey:(NSString *)keyName;
+ (float)floatForKey:(NSString *)keyName;
+ (double)doubleForKey:(NSString *)keyName;
+ (BOOL)boolForKey:(NSString *)keyName;
+ (NSURL *)urlForKey:(NSString *)keyName;
+ (NSDate*)dateForKey:(NSString *)keyName;


@end
