//
//  LJCMeHeadView.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/20.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LJCMeHeadView.h"

@interface LJCProfileView ()
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *titleLabel;

@end

@implementation LJCProfileView

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.numberLabel];
        [self addSubview:self.titleLabel];
        @weakify(self)
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            //make.height.mas_equalTo(self.intrinsicContentSize.height);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.equalTo(self.numberLabel);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.numberLabel.mas_bottom).offset(3);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textColor = WHITE_COLOR;
        return _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *numberLabel = [UILabel new];
        numberLabel.font = [UIFont boldSystemFontOfSize:14];
        numberLabel.textColor = WHITE_COLOR;
        return _numberLabel = numberLabel;
    }
    return _numberLabel;
}

-(void)setLabelTitle:(NSString *)title andNumber:(NSString *)number{
    self.titleLabel.text = title;
    self.numberLabel.text = number;
}

@end


@interface LJCMeHeadView ()
@property(weak,nonatomic)UILabel *titleLabel;
@property(weak,nonatomic)UILabel *sexAddrLabel;
@property(weak,nonatomic)UIImageView *headImgView;
@property(weak,nonatomic)UIButton *searchBtn;
@property(weak,nonatomic)UIButton *settingBtn;
@property(weak,nonatomic)UIStackView *profileView;
@property(strong,nonatomic)UserInfo *localUser;
@end



@implementation LJCMeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.sexAddrLabel];
        [self addSubview:self.headImgView];
        [self addSubview:self.searchBtn];
    }
    return self;
}

-(void)setLocalUser:(UserInfo *)localUser{
    _localUser = localUser;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textColor = WHITE_COLOR;
        return _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)sexAddrLabel{
    if (!_sexAddrLabel) {
        UILabel *sexAddrLabel = [UILabel new];
        sexAddrLabel.font = Font(12);
        sexAddrLabel.textColor = GRAY_COLOR;
        return _sexAddrLabel = sexAddrLabel;
    }
    return _sexAddrLabel;
}

-(UIImageView *)headImgView{
    if (!_headImgView) {
        UIImageView *headImgView = [UIImageView new];
        headImgView.layer.masksToBounds = YES;
        headImgView.layer.cornerRadius = 25;
        return _headImgView = headImgView;
    }
    return _headImgView;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
        
        
        return _searchBtn = searchBtn;
    }
    return _searchBtn;
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingBtn setImage:[UIImage imageNamed:@"button_icon_setting@2x"] forState:UIControlStateNormal];
        
        
        return _settingBtn = settingBtn;
    }
    return _settingBtn;
}

-(UIStackView *)profileView{
    if (!_profileView) {
        UIStackView *profileView = [UIStackView new];
        profileView.axis = UILayoutConstraintAxisHorizontal;
        profileView.alignment = UIStackViewAlignmentFill;
        profileView.distribution = UIStackViewDistributionFillEqually;
        profileView.spacing = 0;
        
        return _profileView = profileView;
    }
    return _profileView;
}

@end
