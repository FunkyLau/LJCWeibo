//
//  SearchUserCollectionViewCell.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/12/1.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "SearchUserCollectionViewCell.h"
#import "Users.h"
#import "SDImageCache.h"

#define BG_COLOR UIColorRGBA(253, 189, 58, 1)
@interface SearchUserCollectionViewCell ()

@property (nonatomic,weak)UIImageView *bgdImageView;
@property (nonatomic,weak)UIImageView *headPicView;
@property (nonatomic,weak)UILabel *nickNameLabel;
@property (nonatomic,weak)UILabel *addrLabel;
@property (nonatomic,weak)UILabel *introLabel;
@property (nonatomic,weak)UIButton *followBtn;
@property (nonatomic,weak)UIImageView *sexImgView;

@end

@implementation SearchUserCollectionViewCell

- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 15;
    self.contentView.layer.shadowOpacity = 0.5;
    self.contentView.layer.shadowColor = GRAY_COLOR.CGColor;
    self.contentView.layer.shadowRadius = 3;
    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
    [self.bgdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(self.contentView.height * 0.4);
        
    }];
    
    [self.headPicView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.center.equalTo(self.contentView.mas_left).offset(60);
        make.centerY.equalTo(self.bgdImageView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.bgdImageView.mas_bottom).offset(-25);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(self.contentView.width/2 - 20);
        make.top.equalTo(self.headPicView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    [self.sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.nickNameLabel.centerY);
        make.width.mas_equalTo(60);
        //make.left.equalTo(self.sexImgView.mas_right).priorityLow;
        
    }];
    
    
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        //make.width.mas_equalTo(self.contentView.width - 40);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
        //make.bottom.equalTo(self.addrLabel.mas_top);
        make.height.mas_equalTo(20);
    }];
    
    [self.addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}


-(UIImageView *)bgdImageView{
    if (!_bgdImageView) {
        UIImageView *bgdImageView = [UIImageView new];
        bgdImageView.backgroundColor = BG_COLOR;
        [self.contentView addSubview:bgdImageView];
        self.bgdImageView = bgdImageView;
    }
    return _bgdImageView;
}

-(UIImageView *)headPicView{
    if (!_headPicView) {
        UIImageView *headPicView = [UIImageView new];
        //headPicView.backgroundColor = [UIColor blueColor];
        headPicView.layer.masksToBounds = YES;
        headPicView.layer.cornerRadius = 25;
        [self.contentView addSubview:headPicView];
        self.headPicView = headPicView;
    }
    return _headPicView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        UILabel *nickNameLabel = [UILabel new];
        nickNameLabel.font = Font(13);
        //nickNameLabel.textColor = GRAY_COLOR;
        [self.contentView addSubview:nickNameLabel];
        self.nickNameLabel = nickNameLabel;
    }
    return _nickNameLabel;
}

-(UILabel *)addrLabel{
    if (!_addrLabel) {
        UILabel *addrLabel = [UILabel new];
        addrLabel.font = Font(13);
        addrLabel.textColor = GRAY_COLOR;
        [self.contentView addSubview:addrLabel];
        self.addrLabel = addrLabel;
    }
    return _addrLabel;
}

-(UILabel *)introLabel{
    if (!_introLabel) {
        UILabel *introLabel = [UILabel new];
        introLabel.font = Font(12);
        introLabel.textColor = GRAY_COLOR;
        [self.contentView addSubview:introLabel];
        self.introLabel = introLabel;
    }
    return _introLabel;
}
//nearby_icon_female  nearby_icon_male
-(UIButton *)followBtn{
    if (!_followBtn) {
        UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[followBtn setImage:[UIImage imageNamed:@"identifying_icon_group"] forState:UIControlStateNormal];
        [followBtn setTitle:@"加关注" forState:UIControlStateNormal];
        [followBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.contentView addSubview:followBtn];
        self.followBtn = followBtn;
    }
    return _followBtn;
}

-(UIImageView *)sexImgView{
    if (!_sexImgView) {
        UIImageView *sexImgView = [UIImageView new];
        
        [self.contentView addSubview:sexImgView];
        self.sexImgView = sexImgView;
    }
    return _sexImgView;
}

#pragma privateMethods

-(void)showValue:(Users *)user{
    NSString *urlStr = user.pictureses.firstObject;
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.sexImgView setImageWithURL:url placeholder:[YYImage imageNamed:@"hi.jpg"]];
    self.nickNameLabel.text = user.usersNikename;
    NSDictionary *userInfoDict = user.userinfos[0];
    self.introLabel.text = userInfoDict[@"userinfoIntro"];
    self.addrLabel.text = userInfoDict[@"userinfoAddress"];
    
}


@end
