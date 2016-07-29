//
//  PhoneNotification.h
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-23.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface PhoneNotification : NSObject
//自动隐藏
+ (void)autoHideWithIndicator;
+ (void)autoHideWithText:(NSString*)text;
+ (void)autoHideWithText:(NSString*)text indicator:(BOOL)show;

//手动隐藏
+ (void)manuallyHideWithIndicator;
+ (void)manuallyHideWithIndicator:(UIView*)toView;
+ (void)manuallyHideWithText:(NSString*)text;
+ (void)manuallyHideWithText:(NSString*)text indicator:(BOOL)show;

//隐藏
+ (void)hideNotification;

+(void)setOffSet:(CGPoint)offset;
+(BOOL)isShow;

@end
