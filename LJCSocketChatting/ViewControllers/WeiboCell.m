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


@interface WeiboCell (){
    
}
@property(nonatomic,weak)UIImageView *headPicView;
@property(nonatomic,weak)UILabel *nickNameLabel;
@property(nonatomic,weak)UILabel *timeLabel;

@property(nonatomic,weak)UIView *contentsView;

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
        _message = [Messages new];
        _message.users = [Users new];
        _message.users.usersNikename = @"大话西游";
        _message.messages_time = @"2小时前";
        _message.messages_info = @"我想从成都挖个人才来我司工作，待遇性格什么都谈好了，他现在只有最后一个问题，就是小孩在上海怎么上学的问题，能解决这个就来。我这方面没经验，咨询一下各位，目前夫妻双方都不是上海人的情况下，怎么解决他小孩上学问题呢？是怎么个流程呢？";
        
    }
    @weakify(self)
    //所有类型的微博都有头像、昵称、时间、微博来源、赞数、转发数、评论数
    [self.contentView addSubview:self.headPicView];
    [self.headPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        
    }];
    [self.contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.headPicView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.size.mas_equalTo(self.nickNameLabel.intrinsicContentSize);
    }];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(self.timeLabel.intrinsicContentSize);
    }];
    
    switch (_weiboType) {
        case WEIBO_ONLY_TEXT:
        {
            [self.contentView addSubview:self.contentsView];
            [self.contentsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.headPicView.mas_right).offset(10);
                make.right.equalTo(self.contentView.mas_right).offset(-10);
                make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
                //make.bottom.equalTo(self.bottomBar.mas_top).offset(-10);
            }];
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
    [self.contentView addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.top.equalTo(self.contentsView.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
    return self;
}
//头像
-(UIImageView *)headPicView{
    if (!_headPicView) {
        UIImageView *headView = [UIImageView new];
        headView.layer.masksToBounds = YES;
        headView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:_message.users.avatarImageURL]];
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
//微博正文
-(UIView *)contentsView{
    if (!_contentsView) {
        UIView *contentsView = [UIView new];
        UITextView *contentTextView = [UITextView new];
        contentTextView.text = _message.messages_info;
        [contentsView addSubview:contentTextView];
        CGSize size = contentTextView.intrinsicContentSize;
        //@weakify(self)
        [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            //@strongify(self)
//            make.left.equalTo(self.headPicView.mas_right).offset(10);
//            make.right.equalTo(self.contentView.mas_right).offset(-10);
//            make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
//            make.bottom.equalTo(self.bottomBar.mas_top).offset(-10);
            //make.edges.equalTo(contentsView);
            make.size.mas_equalTo(size);
        }];
        
        return _contentsView = contentsView;
    }
    return _contentsView;
}

//底部功能栏
-(UIView *)bottomBar{
    if (!_bottomBar) {
        UIView *bottomBar = [UIView new];
        UILabel *platformLabel = [UILabel new];
        platformLabel.font = sysFont(11);
        platformLabel.textColor = DEFAULT_COLOR;
        platformLabel.text = @"iPhone 6";
        platformLabel.backgroundColor = [UIColor redColor];
        [bottomBar addSubview:platformLabel];
        [platformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomBar.mas_left);
            make.top.equalTo(bottomBar.mas_top);
            make.bottom.equalTo(bottomBar.mas_bottom);
        }];
        
        UIStackView *bottomMenuView = [UIStackView new];
        [bottomBar addSubview:bottomMenuView];
        [bottomMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomBar.mas_right);
            make.top.equalTo(bottomBar.mas_top);
            make.bottom.equalTo(bottomBar.mas_bottom);
            make.width.equalTo(@130);
        }];
        
        bottomMenuView.axis = UILayoutConstraintAxisHorizontal;
        bottomMenuView.alignment = UIStackViewAlignmentFill;
        bottomMenuView.distribution = UIStackViewDistributionFillEqually;
        bottomMenuView.spacing = 5;
        UIView *agreeView = [WeiboCell singleViewWithImageName:@"alert_error_icon" andNumber:@"13"];
        agreeView.backgroundColor = [UIColor blueColor];
        UIView *forwardView = [WeiboCell singleViewWithImageName:@"alert_error_icon" andNumber:@"14"];
        forwardView.backgroundColor = [UIColor yellowColor];
        UIView *commentView = [WeiboCell singleViewWithImageName:@"alert_error_icon" andNumber:@"14"];
        commentView.backgroundColor = [UIColor greenColor];
        NSArray *menuArr = @[agreeView,forwardView,commentView];
        for (UIView *view in menuArr) {
            [bottomMenuView addArrangedSubview:view];
        }
        
        
        return _bottomBar = bottomBar;
    }
    return _bottomBar;
}

//

//WEIBO_ONLY_TEXT


+(UIView *)singleViewWithImageName:(NSString *)imageName andNumber:(NSString *)numStr{
    UIView *singleView = [UIView new];
    UIImageView *imageView = [UIImageView new];
    singleView.backgroundColor = [UIColor lightGrayColor];
    [singleView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(singleView.mas_left);
//        make.top.equalTo(singleView.mas_top);
//        make.bottom.equalTo(singleView.mas_bottom);
//        make.right.mas_equalTo(singleView.centerX);
        make.centerY.mas_equalTo(singleView.centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    UILabel *numberLabel = [UILabel new];
    numberLabel.font = sysFont(11);
    numberLabel.text = numStr;
    [singleView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right);
        make.right.equalTo(singleView.mas_right);
        make.top.equalTo(singleView.mas_top);
        make.bottom.equalTo(singleView.mas_bottom);
    }];
    return singleView;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
}


@end
