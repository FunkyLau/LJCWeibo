//
//  AppSettings.m
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-23.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

#pragma mark- 设置
+ (void)setInteger:(NSInteger)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:keyName];
    [ud synchronize];
}

+ (void)setFloat:(float)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:value forKey:keyName];
    [ud synchronize];
}
+ (void)setDouble:(double)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setDouble:value forKey:keyName];
    [ud synchronize];
}
+ (void)setBool:(BOOL)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:keyName];
    [ud synchronize];
}

+ (void)setString:(NSString *)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:keyName];
    [ud synchronize];
}

+ (void)setURL:(NSURL *)value forKey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setURL:value forKey:keyName];
    [ud synchronize];
}
+ (void)setDate:(NSDate*)value forkey:(NSString *)keyName
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:keyName];
    [ud synchronize];
}




#pragma mark- 获取

+ (NSInteger)integerForKey:(NSString *)keyName
{
    NSInteger defValue = 0;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (![ud objectForKey:keyName]) {
        // TODO 添加其它默认参数
    }
    else{
        defValue = [ud integerForKey:keyName];
    }
    return defValue;
}

+ (NSString *)stringForKey:(NSString *)keyName
{
    NSString *defValue = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:keyName]){

    }
    else{
        defValue = [ud stringForKey:keyName];
    }
    return defValue;
}

+ (float)floatForKey:(NSString *)keyName
{
    float defValue = 0.0f;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // 在没有值的情况下设置默认值
    if (![ud objectForKey:keyName]){
    
    }
    else{
        defValue = [ud floatForKey:keyName];
    }
    return defValue;
}

+ (double)doubleForKey:(NSString *)keyName
{
    double defValue = 0.0;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:keyName]){
//        if([keyName isEqualToString:DoubleKey]){
//            defValue = 0.0;// 根据业务需要，填写默认值
//        }
//        else if([keyName isEqualToString:DoubleKey_Ad_UpdateTime])
//            defValue = [[NSDate date] timeIntervalSince1970];
        // TODO 添加其它默认参数
        
    }
    else{
        defValue = [ud doubleForKey:keyName];
    }
    return defValue;
}
+ (BOOL)boolForKey:(NSString *)keyName
{
    BOOL defValue = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if(![ud objectForKey:keyName]){

        if([keyName isEqualToString:BookKey_AutoLogin])
            return YES;

    }
    else{
        defValue = [ud boolForKey:keyName];
    }
    return defValue;
}

+ (NSURL *)urlForKey:(NSString *)keyName
{
    NSURL *defValue = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:keyName]) {
//        if ([keyName isEqualToString:UrlKey]) {
//            defValue = nil;
//        }
        // TODO 添加其它默认参数
        
        
    }
    else{
        defValue = [ud URLForKey:keyName];
    }
    return defValue;
}

+ (NSDate*)dateForKey:(NSString *)keyName
{
    NSDate *defValue = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:keyName]) {
//        if ([keyName isEqualToString:DateKey_NewestNews]) {
//            defValue = nil;
//        }
        // TODO 添加其它默认参数
        
        
    }
    else{
        defValue = [ud objectForKey:keyName];
    }
    return defValue;
}

@end
