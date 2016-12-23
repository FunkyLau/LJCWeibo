//
//  AppHttpInterface.h
//  CreditDemand
//
//  Created by XuXg on 16/1/8.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#ifndef AppHttpInterface_h
#define AppHttpInterface_h


typedef NS_ENUM(NSUInteger, kSeverType) {
    kServer_Dev = 0,        // 开发环境
    kServer_InternalDev,    // 内部开发环境
    kServer_OLTest,         // 在线测试环境
    kServer_Test,           // 测试环境
    kServer_Prodution,      // 生产环境，(正式环境)
    
};



static inline NSString* severURL(kSeverType sType) {
    static NSString *url = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{

        if (sType == kServer_Dev) {
            /**
             * 开发环境---公司地址
             */
            url = @"http://10.1.1.123:8080/weibo2/";
        }
        else if(sType == kServer_InternalDev) {
            /**
             * 开发环境---家里地址
             */
            url = @"http://10.0.1.6:8080/weibo2/";
            
        }
        else if(sType == kServer_Test) {
            /**
             * 公司公网
             */
            url = @"http://58.213.74.122/weibo2/";
        }
        else if(sType == kServer_OLTest) {
            /**
             * 预生产地址,在线测试环境
             */
            url = @"http://139.159.35.149:8090/appInterface/";
        }
        else {
            /**
             * 发布环境地址
             */
            url = @"http://139.159.35.149:8080/appInterface/";
        }
        
//        if (DEBUG) {
//            NSLog(@"当前服务器地址：%@",url);
//        }
    });
    return url;
}



// 只要在下面修改对应的服务器就可以了
#if DEBUG

static const int curSeverType = kServer_Dev;
#else
static const int curSeverType = kServer_Dev;
#endif
#define SeverURL severURL(curSeverType)

#define kLoginWithTel [NSString stringWithFormat:@"%@UsersAction_iosLogin.action", SeverURL]     //用户登录
#define kRegistUser [NSString stringWithFormat:@"%@UsersAction_iosSaveRegister.action", SeverURL]         //用户注册
#define kImageCheck [NSString stringWithFormat:@"%@ImageCheck_execute.action",SeverURL]  //验证码
//用户注册
#define kUserProfile [NSString stringWithFormat:@"%@UserinfoAction_iosUpdateUserInfo.action",SeverURL]


#define kSearchUser [NSString stringWithFormat:@"%@UsersAction_iosSearchUsers.action",SeverURL]  //搜索用户

#define kSubmitSuggest [NSString stringWithFormat:@"%@submitSuggest",SeverURL]    //意见反馈

#define kGetHotComment @"getHotComment"         //获取热门评论
#define kGetMyFollowCp [NSString stringWithFormat:@"%@getMyFollowCp",SeverURL]          //获取关注列表
#define kUpdateMyFollowCp [NSString stringWithFormat:@"%@updateMyFollowCp",SeverURL]    //变更我的关注

// 我的产品
#define kQueryMessages [NSString stringWithFormat:@"%@MessagesAction_iosQueryMessages.action",SeverURL]    //获取全部订单
#define kSendMessages [NSString stringWithFormat:@"%@MessagesAction_iosSaveMessages.action",SeverURL]  //取消订单
#define kMyProduct [NSString stringWithFormat:@"%@queryMyProduct",SeverURL]
#define kSaveProductOrder [NSString stringWithFormat:@"%@saveOrder",SeverURL]           // 保存产品订单
#define kGetEntpriseComment [NSString stringWithFormat:@"%@getComment",SeverURL]            // 企业评论
#define kCommitComment [NSString stringWithFormat:@"%@addComment",SeverURL]         // 提交评论

// 购物车列表
#define kShoppingCartList [NSString stringWithFormat:@"%@queryHoppingCartGoodsList",SeverURL]
// 保存商品到购物车
#define kSaveProductToShoppingCart [NSString stringWithFormat:@"%@saveToHoppingCart",SeverURL]
// 删除购物车中的商品
#define kDeleteProductFromShoppingCart [NSString stringWithFormat:@"%@deleteGoodsFromHoppingCart",SeverURL]
// 添加商品到购物车
#define kAddProductToShoppingCart [NSString stringWithFormat:@"%@addGoodsToHoppingCart",SeverURL]
    
// 产品查询(网络实名，个人投资，个人司法，企业司法等)
#define kQueryProductInfo [NSString stringWithFormat:@"%@queryGoodsInfoList",SeverURL]

// banner
#define kGetBanner [NSString stringWithFormat:@"%@getBanner",SeverURL]

// 个人和公司的司法查询
#define kJusticeQuery [NSString stringWithFormat:@"%@lawInfo",SeverURL]

// 上传债权信息
#define kSaveClaims [NSString stringWithFormat:@"%@saveClaimsAndDebt",SeverURL]
// 上传债权图片
#define kUploadDebtImage [NSString stringWithFormat:@"%@uploadDeptImg",SeverURL]


#endif /* AppHttpInterface_h */
