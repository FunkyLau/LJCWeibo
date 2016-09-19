//
//  UIButton+UIButtonImageWithLable.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/14.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "UIButton+UIButtonImageWithLable.h"

@implementation UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithFont:Font(12.0f)];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              -titleSize.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:Font(12.0f)];
    [self.titleLabel setTextColor:BLACK_COLOR];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              -image.size.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}
//备注：如果不需要上下显示，只需要横向排列的时候，就不需要设置左右偏移量了，代码如下
/*
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithFont:HELVETICANEUEMEDIUM_FONT(12.0f)];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:HELVETICANEUEMEDIUM_FONT(12.0f)];
    [self.titleLabel setTextColor:COLOR_ffffff];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}
 */
@end
