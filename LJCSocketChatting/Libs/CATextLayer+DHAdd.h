//
//  CATextLayer+DHAdd.h
//  CreditDemand
//
//  Created by XuXiaoGuang on 16/3/7.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CATextLayer (DHAdd)

// 代码没有测试，可能会有不可预知的问题
- (CGSize)sizeThatFits:(CGSize)size;     // return 'best' size to fit given size. does not actually resize view. Default is return existing view size

// 代码没有测试，可能会有不可预知的问题
- (void)sizeToFit;                       // calls sizeThatFits: with current view bounds and changes bounds size.
@end
