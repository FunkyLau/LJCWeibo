//
//  PhoneNotification.m
//  FSFTownFinancial
//
//  Created by yujiuyin on 14-7-23.
//  Copyright (c) 2014年 yujiuyin. All rights reserved.
//
#import "PhoneNotification.h"
#import "NSString+Extensions.h"

#define kHideTime   2.0f    // 自动隐藏的时间
#define kLabelFont  15.0f   // title字体大小



@implementation PhoneNotification
MBProgressHUD* hud = nil;

+(MBProgressHUD*)buildHUD:(UIView*)toView {
    
    if (hud) {
        [hud hideAnimated:YES];
        hud = nil;
    }
    
    if (!toView) {
        toView = theApp.window;
    }
    hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.userInteractionEnabled = NO;
    hud.offset = CGPointZero;
    [hud setRemoveFromSuperViewOnHide:YES];
//    hud.bezelView.backgroundColor = [UIColor redColor];
    return hud;
}

+(UIFont*)titleFont {
    static UIFont *font = nil;
    if (!font) {
        font = [UIFont systemFontOfSize:kLabelFont];
    }
    return font;
}


// 自动隐藏
+ (void)autoHideWithIndicator {
    
    [self manuallyHideWithIndicator];
    [hud hideAnimated:YES afterDelay:kHideTime];
}

+ (void)autoHideWithText:(NSString*)text
{
    [self manuallyHideWithText:text];
    [hud hideAnimated:YES afterDelay:kHideTime];
}

+ (void)autoHideWithText:(NSString*)text indicator:(BOOL)show
{
    [self manuallyHideWithText:text indicator:show];
    [hud hideAnimated:YES afterDelay:kHideTime];
}

//手动隐藏
+ (void)manuallyHideWithIndicator
{
    [self.class buildHUD:nil];
}
+ (void)manuallyHideWithIndicator:(UIView*)toView
{
    [self.class buildHUD:toView];
}

+ (void)manuallyHideWithText:(NSString*)text
{
    if (text == nil || [text isEmptyOrBlank]) {
        return [self manuallyHideWithIndicator];
    }

    MBProgressHUD *hud = [self.class buildHUD:nil];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = [self titleFont];
}

+ (void)manuallyHideWithText:(NSString*)text
                   indicator:(BOOL)show {
    
    if (text == nil || [text isEmptyOrBlank]) {
        return [self manuallyHideWithIndicator];
    }
    
    if (!show) {
        return [self manuallyHideWithText:text];
    }
    
    MBProgressHUD *hud = [self.class buildHUD:nil];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.label.font = [self titleFont];
}

//隐藏
+ (void)hideNotification
{
    [hud hideAnimated:YES];
}


+(void)setOffSet:(CGPoint)offset {
    hud.offset = offset;
}

+(BOOL)isShow {
    return  (hud && ![[hud valueForKey:@"hasFinished"] boolValue]);
}
@end

