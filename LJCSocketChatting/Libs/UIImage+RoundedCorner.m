//
//  UIImage+RoundedCorner.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/8/9.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "UIImage+RoundedCorner.h"

@implementation UIImage (RoundedCorner)
//多UIImage需要圆角防止离屏渲染
-(UIImage *)imageWithRoundedCornerAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius{
    CGRect rect = (CGRect){0.f,0.f,sizeToFit};
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
