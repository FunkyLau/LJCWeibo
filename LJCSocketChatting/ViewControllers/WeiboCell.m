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
#import "UIImageView+WebCache.h"

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
        //所有类型的微博都有头像、昵称、时间、微博来源、赞数、转发数、评论数
        [self.contentView addSubview:self.headPicView];
        [self.contentView addSubview:self.nickNameLabel];
        [self.contentView addSubview:self.timeLabel];
        //[self.contentView addSubview:self.contentsView];
        [self.contentView addSubview:self.bottomBar];
        
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //[self.contentView layoutIfNeeded];
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
        
        return _nickNameLabel = label;
    }
    return _nickNameLabel;
}

//发布时间
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [UILabel new];
        label.font = sysFont(12);
        
        label.textColor = DEFAULT_COLOR;
        return _timeLabel = label;
    }
    return _timeLabel;
}
//微博正文
-(UIView *)contentsView{
    
    switch (_weiboType) {
        case WEIBO_ONLY_TEXT:
        {
            if (!_contentsView) {
                return _contentsView = [self onlyTextView];
                //return _contentsView = [self textPicView];
            }
            break;
        }
        case WEIBO_TEXT_PIC:
        {
            if (!_contentsView) {
                return _contentsView = [self textPicView];
            }
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
        UIView *agreeView = [WeiboCell singleViewWithImageName:@"timeline_item_like_icon" andNumber:@"13"];
        UIView *forwardView = [WeiboCell singleViewWithImageName:@"timeline_item_forward_icon" andNumber:@"14"];
        UIView *commentView = [WeiboCell singleViewWithImageName:@"timeline_item_commented_icon" andNumber:@"14"];
        NSArray *menuArr = @[agreeView,forwardView,commentView];
        for (UIView *view in menuArr) {
            [bottomMenuView addArrangedSubview:view];
        }
        
        return _bottomBar = bottomBar;
    }
    return _bottomBar;
}

//WEIBO_ONLY_TEXT
-(UIView *)onlyTextView{
    UIView *contentsView = [UIView new];
    UILabel *contentTextView = [UILabel new];
    contentTextView.text = _message.messagesInfo;
    contentTextView.numberOfLines = 0;
    contentTextView.font = Font(12);
    [contentsView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentsView);
    }];
    //这两句非常重要！自适应布局
    [contentsView sizeToFit];
    [contentsView layoutIfNeeded];
    return contentsView;
}
//WEIBO_TEXT_PIC
-(UIView *)textPicView{
    UIView *contentsView = [UIView new];
    UILabel *contentTextView = [UILabel new];
    contentTextView.text = _message.messagesInfo;
    contentTextView.numberOfLines = 0;
    contentTextView.font = Font(12);
    [contentsView addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(contentsView);
        make.left.equalTo(contentsView.mas_left);
        make.right.equalTo(contentsView.mas_right);
        make.top.equalTo(contentsView.mas_top);
    }];
    //这两句非常重要！自适应布局
    [contentsView sizeToFit];
    
    UIImageView *contentImageView = [UIImageView new];
    //contentImageView.backgroundColor = [UIColor lightGrayColor];
    //[contentImageView setImageURL:[NSURL URLWithString:@"http://i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"]];
    [contentImageView sd_setImageWithURL:[NSURL URLWithString:@"i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"] placeholderImage:[UIImage imageNamed:@"jamFilter2"]];
    //[contentImageView setImageWithURL:[NSURL URLWithString:@"http://i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"] placeholder:[UIImage imageNamed:@"jamFilter2"]];
    contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    [contentsView addSubview:contentImageView];
    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentTextView.mas_left);
        make.right.equalTo(contentTextView.mas_right);
        make.top.equalTo(contentTextView.mas_bottom).offset(5);
        make.bottom.equalTo(contentsView.mas_bottom).offset(-5);
        make.height.equalTo(@100);
    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"]];
//        //YYImage *image = [YYImage imageWithContentsOfFile:@"http://i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"];
//        [contentImageView setImageURL:[NSURL URLWithString:@"http://i.ce.cn/ce/culture/gd/201411/17/W020141117625155200846.jpg"]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //contentImageView.image = image;
//            [contentsView layoutIfNeeded];
//        });
//        
//    });
    return contentsView;
}

+(UIView *)singleViewWithImageName:(NSString *)imageName andNumber:(NSString *)numStr{
    UIView *singleView = [UIView new];
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:imageName];
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


//-(void)didMoveToSuperview {
//    [self layoutIfNeeded];
//}

- (void)bindCellDataWithMessage:(Messages *)message{
    _message = message;
    
    self.headPicView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:_message.users.avatarImageURL]];
    self.nickNameLabel.text = _message.users.usersNikename;
    self.timeLabel.text = _message.messagesTime;
    
    [self.contentView addSubview:self.contentsView];
    
    [self.headPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headPicView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.size.mas_equalTo(self.nickNameLabel.intrinsicContentSize);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(self.timeLabel.intrinsicContentSize);
    }];
    
    [self.contentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headPicView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
        //make.bottom.equalTo(self.bottomBar.mas_top).offset(-10);
    }];
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.contentsView.mas_bottom).offset(10);
        
    }];
    //[self layoutIfNeeded];
}
@end
