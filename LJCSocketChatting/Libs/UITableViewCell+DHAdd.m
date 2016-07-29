//
//  UITableViewCell+DHAdd.m
//  CreditDemand
//
//  Created by XuXg on 16/1/10.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "UITableViewCell+DHAdd.h"

@implementation UITableViewCell (DHAdd)

/**
 *  获取cell所在的TableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    UIView *view;
    for (view = self.superview; ![view isKindOfClass:UITableView.class]; view = view.superview);
    return (UITableView *)view;
}

@end
