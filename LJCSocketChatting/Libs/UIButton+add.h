//
//  UIButton+add.h
//  CreditDemand
//
//  Created by XuXg on 16/1/7.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ActionBlock)();
@interface UIButton (add)

// 添加一个block函数
- (void)handleControlEvent:(UIControlEvents)controlEvent
                 withBlock:(ActionBlock)action;


/**
 *  设置button点击扩大的范围
 *
 *  @param top    上扩大值
 *  @param right  右扩大值
 *  @param bottom 底部扩大值
 *  @param left   左边扩大值
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;


// 获取按钮点击扩大的区域
-(CGRect)enlargeFrame;

@end
