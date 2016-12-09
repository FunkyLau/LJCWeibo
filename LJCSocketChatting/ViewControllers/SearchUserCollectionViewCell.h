//
//  SearchUserCollectionViewCell.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/12/1.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Users;

@interface SearchUserCollectionViewCell : UICollectionViewCell

-(void)showValue:(Users *)user;
@end
