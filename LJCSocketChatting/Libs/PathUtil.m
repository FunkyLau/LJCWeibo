//
//  PathUtil.m
//  SurfNews
//
//  Created by apple on 12-11-1.
//
//

#import "PathUtil.h"
#import "FileUtil.h"



#define kUserDir @"User"
#define kLibBannerDir @"Banners"
#define kLibProducts  @"Products"


// Documents/User/
// Library/Banners
// Library/Products
// tep/



@implementation PathUtil

+ (void)ensureLocalDirsPresent {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    
    NSString *userPath = [self rootPathOfUser];
    NSString *bannerPath = [self rootPathOfBanner];
    NSString *products = [self rootPathOfProducts];

    [fm createDirectoryAtPath:userPath
  withIntermediateDirectories:NO attributes:nil error:nil];
    [fm createDirectoryAtPath:bannerPath
  withIntermediateDirectories:NO attributes:nil error:nil];
    [fm createDirectoryAtPath:products
  withIntermediateDirectories:NO attributes:nil error:nil];
    
    //DO NOT BACKUP
    [FileUtil addSkipBackupAttributeForPath:[self documentsPath]];  //保险起见，把documents根目录也设为DO NOT BACKUP
    [FileUtil addSkipBackupAttributeForPath:userPath];
    [FileUtil addSkipBackupAttributeForPath:bannerPath];
    [FileUtil addSkipBackupAttributeForPath:products];
}

+ (NSString *)surfDbFilePath {
    return [[self documentsPath] stringByAppendingPathComponent:@"SurfNewsDb.db"];
}

+ (NSString *)documentsPath {
    static dispatch_once_t token;
    static NSString* documentPath = nil;
    dispatch_once(&token, ^{
        documentPath =
        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    return documentPath;
}

+(NSString*)libraryPath {
    static dispatch_once_t token;
    static NSString *libraryPath = nil;
    dispatch_once(&token, ^{
        libraryPath =
        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    });
    return libraryPath;
}

// 临时路径
+(NSString*)tmpPath {
    static dispatch_once_t token;
    static NSString *tmpPath = nil;
    dispatch_once(&token, ^{
        tmpPath = NSTemporaryDirectory();
    });
    return tmpPath;
}


//获取main bundle根目录中名称为@name的资源的路径
+ (NSString *)pathOfResourceNamed:(NSString*)name
{
    return [[NSBundle mainBundle] pathForResource:[[name lastPathComponent] stringByDeletingPathExtension] ofType:[name pathExtension]];
}

+ (NSString *)pathOfResourceNamed:(NSString *)name inBundleDir:(NSString*)dir
{
    return [[NSBundle mainBundle] pathForResource:[[name lastPathComponent] stringByDeletingPathExtension] ofType:[name pathExtension] inDirectory:dir];
}

#pragma mark- UserDir 路径下的文件
+ (NSString*)rootPathOfUser {
    return [[self documentsPath] stringByAppendingPathComponent:kUserDir];
}

+(NSString *)pathOfCacheMessages{
    return [[self rootPathOfUser] stringByAppendingPathComponent:@"messages.txt"];
}

// document/User/
+ (NSString*)pathOfUserInfo
{
    return [[self rootPathOfUser] stringByAppendingPathComponent:@"userinfo.txt"];
}

+ (NSString *)pathUserHeadPic{
    return [[self rootPathOfUser] stringByAppendingPathComponent:@"headPic.png"];
}

+(NSString *)pathFeedbackPic{
    return [[self rootPathOfUser] stringByAppendingPathComponent:@"feedbackPic.png"];
}

+ (NSString*)pathOfQueriedINBInfo:(NSString *)enterName
{
    return [[self rootPathOfUser] stringByAppendingPathComponent:[NSString stringWithFormat:@"INB%@.txt",enterName]];
}

+(NSString *)pathOfQueriedJusticeInfo:(NSString *)queryName{
    return [[self rootPathOfUser] stringByAppendingPathComponent:[NSString stringWithFormat:@"JUS%@.txt",queryName]];
}

#pragma mark- Lib Banner path
// Library/Banners/
+ (NSString*)rootPathOfBanner {
    return [[self libraryPath] stringByAppendingPathComponent:kLibBannerDir];
}

+(NSString*)pathOfBannersInfo {
    return [[self rootPathOfBanner] stringByAppendingPathComponent:@"bannerInfo.txt"];
}

// Library/products/
+(NSString*)rootPathOfProducts {
    return [[self libraryPath] stringByAppendingPathComponent:kLibProducts];
}
+(NSString*)pathOfProductsInfo {
    return [[self rootPathOfProducts] stringByAppendingPathComponent:@"productsInfo.txt"];
}
@end
