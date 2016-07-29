//
//  DHGridView.h
//  CreditDemand
//
//  Created by XuXg on 16/1/10.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHGridView : UIView


/**
 * @brief 网格间距，默认30
 */
@property (nonatomic, assign) CGSize gridSize;
/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat   gridLineWidth;
/**
 * @brief 网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor   *gridColor;
@end