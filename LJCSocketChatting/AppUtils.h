//
//  AppUtils.h
//  CreditDemand
//
//  Created by XuXg on 16/1/8.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#ifndef AppUtils_h
#define AppUtils_h
#import "DHMaterialDesignSpinner.h"




// 加载图片
#define IMAGE(a)                     [UIImage imageNamed:(a)]
#define IMAGE_No_Cache(a)            [YYImage imageNamed:(a)]

// 防止循环引用
#define WS(weakSelf)      __weak __typeof(&*self)weakSelf = self;
#define BS(blockSelf)     __block __typeof(&*self)blockSelf = self;

// 应用版本号
//#define AppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey])


#pragma mark - /////////// 字体 /////////////
#define sysFont(a)      [UIFont systemFontOfSize:(a)]
#define bolFont(a)      [UIFont boldSystemFontOfSize:(a)]
#define itaFont(a)      [UIFont italicSystemFontOfSize:(a)]


#pragma mark - /////////// 颜色值 /////////////
#define buttonSelectedColor UIColorHex(3db6e6) // 定义各产品页面选择按钮颜色
#define PDTDSCR_COLOR UIColorHex(666666)       // 定义各产品页面产品描述字体颜色
#define Product_Btn_Disabled UIColorHex(e4e8e9) // 产品按钮失去激活颜色

//【帮助反馈】->反馈按钮背景颜色（橙色）
#define FeedbackBtnBgColor UIColorHex(fa6c6e)

#define kMenuBackColor UIColorHex(00000066)




#pragma mark - /////////// 支付宝 ////////////
// 阿里合作伙伴
#define AlipayPARTNER           @"2088021394737408"
// 商户收款账号
#define AlipaySELLER            @"nj.xuebin@dhjt.com"
// 阿里私钥
#define AlipayRSA_PRIVATE       @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALB3mDEyozhvE4XcZeCCogPjr1wQSLRixRcHgcpd85Kk1LIJoGztvh0sBVFKqzPy9sjDGgLxrpIs+VFEvb+1L+VI1p73+10GQ0whv5uzRZc9zfTxya4pRqewWPu3QKJYWUQ6NRjyPcUfNTSgEYM5KNQuMId0wwDTOHkk9gddT7rzAgMBAAECgYEAmyDHPZiSO64Jr4dMV8z+uASTx47ZGxoowFHtGwT0dllIUSp9SMTGd8aW9ht53TUdFOfOGgBzwjSfB34ygDC7ZJI2Lg8Gs0uPUE5BY/f/gt42eHTJSx1WjQex0QWPneBZGfX1ka4pMmb6pH7KOHTjXRq3yCL3NgS0SbGydyHpbgECQQDfdMOahwOHH+13/LoixAbLik5F6gTSQUm+U7v4zGiVr6pSPirVSFiljYLoyUMZb48y/iXP8kxdpHfU5Q+xMTszAkEAyirqgNJPkZN4sfcgg5q8xGj7hzKvQ8gyI9039jDPoa2pRF/DYqxw3Vhe74r6SyWFwixzMUBJQ6P5LmI6ExmBQQJAWQWOi7hwGlwI4f1oNkN8JYiTCF1j0FO8SjvXrhXZMJEMPLmRnOi2kDXhSlYsCi0ckocXj1GLRN8p8kHTT5c6awJAVcHOp8aOqhn8YMGLsUe6OzatO7RsVDxfyIbWbkBWUybvXmmg4AJ1/e62lrZFZgsMqklgs8upSGAOG3bfW6q+AQJBALOTBhGjbM6+jaMDhtFCk2rfNntOfgdVH2yxgbvureV2TCQ98/emzDrtyY0Ppz7wOo9ptW6sbZZ7UD+HJFLz284="
// 阿里共钥
#define AlipayRSA_ALIPAY_PUBLIC @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwd5gxMqM4bxOF3GXggqID469cEEi0YsUXB4HKXfOSpNSyCaBs7b4dLAVRSqsz8vbIwxoC8a6SLPlRRL2/tS/lSNae9/tdBkNMIb+bs0WXPc308cmuKUansFj7t0CiWFlEOjUY8j3FHzU0oBGDOSjULjCHdMMA0zh5JPYHXU+68wIDAQAB"

//支付宝服务器主动通知商户网站里指定的页面http路径。
//获取服务器端支付数据地址（商户自定义）
#define AlipayNotifyURL [NSString stringWithFormat:@"%@alipayCallBack", SeverURL]


//////////////////////////微信//////////////////////////////
#define WeChatAppID             @""
#define WeChatAppSecret         @""
//商户号，填写商户对应参数
#define WeChatMCH_ID                  @""
//商户API密钥，填写相应参数
#define WeChatPARTNER_ID              @""
//支付结果回调页面
#define WeChatNOTIFY_URL              @""
//获取服务器端支付数据地址（商户自定义）
#define SP_URL   @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

//http://pay1.fujin.com/aspx/alipayreturn_m.aspx?f=app1


#pragma mark - 系统属性
//////////////////////////系统属性//////////////////////////////




#pragma mark - app属性
//////////////////////////app属性//////////////////////////////
/* 
 1 身份认证
 2 水纹照片
 3 工商信息
 4 个人司法报告
 5 企业司法报告
 6 个人对外投资
 */
#define kCyberRealname @"1" // 身份认证
#define kPoliceWave @"2"
#define kINBQueryGoodsId @"3"
#define kPersonalJustice @"4"
#define kEnterpriseJustice @"5"
#define kPersonalInvestment @"6"
#define kDeepReport @"7"

#define kProductMaxNumber 999

/**
 *  判断字符串是不是空串(如果字符内容是空格符，也会算是空串)
 *
 *  @param str 字符串
 *
 *  @return YES or NO
 */
static inline BOOL strIsNil(NSString* str) {
    if (!str || [str isEmptyOrBlank]) {
        return YES;
    }
    return NO;
}

/**
 *  延迟调用，在主线程中。
 *
 *  @param delayInSeconds 秒
 *  @param block          回调函数
 *
 *  @return 无
 */
static inline void dispatchAfterOnMainThread(int delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

// 无线加载圆环进度控件。
// 位置是屏幕居中向上一点
static inline DHMaterialDesignSpinner* createDesignSpinner(){
    
    CGFloat w = 40.f , h = 40.f;
    CGFloat x = (kScreenWidth-w)/2.f;
    CGFloat y = (kScreenHeight-h)/2.f - 10.f;
    CGRect r = CGRectMake(x, y, w, h);
    DHMaterialDesignSpinner *spinner =
    [[DHMaterialDesignSpinner alloc] initWithFrame:r];
    spinner.tintColor = [UIColor grayColor];
    spinner.lineWidth = 2;
    spinner.translatesAutoresizingMaskIntoConstraints = NO;
    spinner.userInteractionEnabled = NO;
    [spinner startAnimating];
    return spinner;
}

typedef enum : NSUInteger {
    CELL_TITLE,
    CELL_DETAIL,
} CELLTYPE;


#endif /* AppUtils_h */
