//
//  CATextLayer+DHAdd.m
//  CreditDemand
//
//  Created by XuXiaoGuang on 16/3/7.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "CATextLayer+DHAdd.h"

@implementation CATextLayer (DHAdd)



+ (UIFont *)uifontFromCTFontRef:(CTFontRef)ctFont {
    CGFloat pointSize = CTFontGetSize(ctFont);
    NSString *fontPostScriptName = (NSString *)CFBridgingRelease(CTFontCopyPostScriptName(ctFont));
    UIFont *fontFromCTFont = [UIFont fontWithName:fontPostScriptName size:pointSize];
    return fontFromCTFont;
}

+ (CTFontRef)ctFontRefFromUIFont:(UIFont *)font {
    CTFontRef ctfont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    return CFAutorelease(ctfont);
}




- (UIFont *)fontForTextLayer
{
    
    UIFont *font = [UIFont fontWithCGFont:(CGFontRef)self.font
                                     size:self.fontSize];
    return font;
}



- (CGSize)sizeThatFits:(CGSize)size {
    

    
    UIFont *font = [self.class fontForTextLayer];
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    
    return [self.string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

- (void)sizeToFit {
    CGSize s = [self sizeThatFits:CGSizeZero];
    self.size = s;
}
@end
