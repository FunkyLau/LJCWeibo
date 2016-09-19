//
//  UIButton+UIButtonImageWithLable.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/14.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
