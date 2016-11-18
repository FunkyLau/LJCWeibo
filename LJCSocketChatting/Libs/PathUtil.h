//
//  PathUtil.h
//  SurfNews
//
//  Created by apple on 12-11-1.
//
//

#import <Foundation/Foundation.h>


@interface PathUtil : NSObject

+ (void)ensureLocalDirsPresent;

//数据库文件路径
+ (NSString *)surfDbFilePath;

//document文件夹路径
+ (NSString *)documentsPath;

//获取main bundle根目录中名称为@name的资源的路径
+ (NSString *)pathOfResourceNamed:(NSString*)name;

//获取main bundle下指定目录中名称为@name的资源的路径
+ (NSString *)pathOfResourceNamed:(NSString *)name inBundleDir:(NSString*)dir;

+ (NSString*)rootPathOfUser;

//首页缓存messages
+(NSString *)pathOfCacheMessages;
//用户信息列表
+ (NSString*)pathOfUserInfo;

//头像路径
+ (NSString *)pathUserHeadPic;

//反馈图片
+(NSString *)pathFeedbackPic;

//已查询的工商信息缓存
+ (NSString*)pathOfQueriedINBInfo:(NSString *)enterName;

//司法信息缓存路径
+(NSString *)pathOfQueriedJusticeInfo:(NSString *)queryName;

// 查询历史记录
+(NSString *)pathOfSearchHistory;

+(NSString*)pathOfBannersInfo;
// 产品信息路径
+(NSString*)pathOfProductsInfo;
@end
