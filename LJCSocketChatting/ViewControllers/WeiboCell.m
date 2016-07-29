//
//  WeiboCell.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/27.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "WeiboCell.h"
#import "Messages.h"
#import "Users.h"


@interface WeiboCell ()
@property(nonatomic,weak)UIImageView *headPicView;
@property(nonatomic,weak)UILabel *nickNameLabel;
@property(nonatomic,weak)UILabel *timeLabel;

//@property(nonatomic,weak)UILabel *platformLabel;
//@property(nonatomic,weak)UIButton *zanBtn;
//@property(nonatomic,weak)UIButton *forwardBtn;
//@property(nonatomic,weak)UIButton *commentBtn;

@property(nonatomic,weak)UIView *bottomBar;//包含上面的控件

@end


@implementation WeiboCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
    }
    //所有类型的微博都有头像、昵称、时间、微博来源、赞数、转发数、评论数
    [self.contentView addSubview:self.headPicView];
    
    
    switch (_weiboType) {
        case WEIBO_ONLY_TEXT:
        {
            
            break;
        }
        case WEIBO_TEXT_PIC:
        {
            
            break;
        }
        case FWD_TEXT:
        {
            
            break;
        }
        case FWD_TEXT_PIC:
        {
            
            break;
        }
    
    }
    
    return self;
}
//头像
-(UIImageView *)headPicView{
    if (!_headPicView) {
        UIImageView *headView = [UIImageView new];
        headView.layer.masksToBounds = YES;
        headView.layer.cornerRadius = 20;
        headView.backgroundColor = GRAY_COLOR;
        return _headPicView = headView;
    }
    return _headPicView;
}

//昵称
-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        UILabel *label = [UILabel new];
        label.font = sysFont(14);
        label.text = _message.users.usersNikename;
        return _nickNameLabel = label;
    }
    return _nickNameLabel;
}

//发布时间
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [UILabel new];
        label.font = sysFont(12);
        label.text = _message.messages_time;
        label.textColor = DEFAULT_COLOR;
        return _timeLabel = label;
    }
    return _timeLabel;
}

//底部功能栏
-(UIView *)bottomBar{
    if (!_bottomBar) {
        
        
        
        
        
        
        
    }
    return _bottomBar;
}

//

//WEIBO_ONLY_TEXT




-(void)layoutSubviews{
    [super layoutSubviews];
    
}


@end
