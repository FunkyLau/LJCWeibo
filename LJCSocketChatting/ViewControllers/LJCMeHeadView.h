//
//  LJCMeHeadView.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/20.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Users;

@interface LJCMeHeadView : UIView
- (instancetype)initWithTableView:(UITableView *)tableView initialHeight:(CGFloat)height;
-(void)setLocalUser:(Users *)localUser;
-(void)loadUserInfo:(Users *)user;
-(void)createSubviews;
@end


@interface LJCProfileView : UIView
-(void)setLabelTitle:(NSString *)title andNumber:(NSString *)number;
@end
