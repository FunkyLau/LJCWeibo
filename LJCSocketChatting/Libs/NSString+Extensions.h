//
//  NSString+UrlEncoding.h
//  SurfNewsHD
//
//  Created by yujiuyin on 13-1-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlEncoding)

//utf8 encoding by default
-(NSString*) urlEncodedString;
-(NSString*) urlEncodedGbkString;

//utf8 encoding by default
-(NSString*) urlDecodedString;


@end

@interface NSString (OtherExtentions)

//从逻辑上判断是否相等
//nil和空串等同
+(BOOL) isString:(NSString*)s1 logicallEqualsToString:(NSString*)s2;

//返回完全形式的url(追加http://)
-(NSString*) completeUrl;

-(NSString*) trim;

-(NSString*) trimLeft;

-(NSUInteger) indexOfString:(NSString*)str;

-(NSUInteger) lastIndexOfString:(NSString*)str;

-(BOOL) contains:(NSString*)str;
-(BOOL) containsCasInsensitive:(NSString*)str;

-(BOOL) isEqualToStringCaseInsensitive:(NSString *)aString;

-(BOOL) hasPrefixCaseInsensitive:(NSString*)prefix;
-(BOOL) hasSuffixCaseInsensitive:(NSString *)suffix;

-(BOOL) isEmptyOrBlank;

- (BOOL)isEmailValid;

- (BOOL)isMobileNumber;

-(NSStringEncoding) convertToStringEncoding;

- (BOOL)isJustNum;

// 是否包含表情符号
- (BOOL)isContainsEmoji;

/**
 *  是否包含特殊字符
 *
 *  @return
 */
-(BOOL)isContainsSpecialCharacters;

// 简单验证身份证(只对格式验证，有效性需要公安部门)
-(BOOL)isIdentityCard;

/**
 * 校验银行卡卡号
 * @param cardId
 * @return
 */
-(BOOL)isValidCardNumber;

// 是不是中文字
-(BOOL)isChinaCharacter;

//comment from yujiuyin:
//此函数名有歧义，到底是【中国移动】手机号
//还是中国的手机号？
//看其实现，貌似是后者
-(BOOL) isChinaMobileNumber;

//----------版本号比较----------
//支持1.0.3、1.2.3.4等各种形式的相互比较
-(BOOL) isVersionLowerThan:(NSString*)version;
-(BOOL) isVersionLowerThanOrEqualsTo:(NSString*)version;
-(BOOL) isVersionEqualsTo:(NSString*)version;
-(BOOL) isVersionHigherThan:(NSString*)version;
-(BOOL) isVersionHigherThanOrEqualsTo:(NSString*)version;

//将字节数转化为用户友好的字符串表达
//例：10.25MB、3.05kB
+(NSString*) readableStringWithBytes:(long long)bytes;


// 将时间字符串转换成指定格式的字符串
// 例如：@"1460568700" to 2016-04-14-01
// format: @"yyyy-MM-dd"
-(NSString*) dateStrWithFormat:(NSString*)format;

// 转换成数字字串,过滤掉非数字字串。
// 例如：@"11B22BB33" = @"112233"
-(NSString*)transformToNumber;

//  截取小数点之前的字符串,在后面拼接"万"
- (NSString *)cutZeroFromREGCAP;

@end


//htmlencoding
//源码来自gtm
@interface NSString (HtmlEncoding)

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'. This will only cover characters from table
///  A.2.2 of http://www.w3.org/TR/xhtml1/dtds.html#a_dtd_Special_characters
///  which is what you want for a unicode encoded webpage. If you have a ascii
///  or non-encoded webpage, please use stringByEscapingAsciiHTML which will
///  encode all characters.
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForHTML;

/// Get a string where internal characters that need escaping for HTML are escaped
//
///  For example, '&' become '&amp;'
///  All non-mapped characters (unicode that don't have a &keyword; mapping)
///  will be converted to the appropriate &#xxx; value. If your webpage is
///  unicode encoded (UTF16 or UTF8) use stringByEscapingHTML instead as it is
///  faster, and produces less bloated and more readable HTML (as long as you
///  are using a unicode compliant HTML reader).
///
/// For obvious reasons this call is only safe once.
//
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByEscapingForAsciiHTML;

/// Get a string where internal characters that are escaped for HTML are unescaped
//
///  For example, '&amp;' becomes '&'
///  Handles &#32; and &#x32; cases as well
///
//  Returns:
//    Autoreleased NSString
//
- (NSString *)stringByUnescapingFromHTML;


@end