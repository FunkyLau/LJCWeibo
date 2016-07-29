//
//  WeiboCell.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/27.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Messages;


typedef enum : NSUInteger {
    WEIBO_ONLY_TEXT,
    WEIBO_TEXT_PIC,
    FWD_TEXT,
    FWD_TEXT_PIC
} WEIBOTYPE;

@interface WeiboCell : UITableViewCell
@property(nonatomic,assign)WEIBOTYPE weiboType;
@property(nonatomic,strong,readonly)Messages *message;

@end
