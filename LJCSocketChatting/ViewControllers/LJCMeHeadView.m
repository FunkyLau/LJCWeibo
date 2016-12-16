//
//  LJCMeHeadView.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/20.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LJCMeHeadView.h"
#import "Users.h"
#import "Messages.h"
#import "Userinfo.h"


@interface LJCProfileView ()
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UIView *lineView;
@end

@implementation LJCProfileView

-(instancetype)init{
    if (self = [super init]) {
        
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.08];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_centerY);
            //make.height.mas_equalTo(self.intrinsicContentSize.height);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.numberLabel);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.numberLabel.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(self.mas_left);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}



-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textColor = UIColorHex(42474B);//42474B
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *numberLabel = [UILabel new];
        numberLabel.font = [UIFont boldSystemFontOfSize:18];
        numberLabel.textColor = WHITE_COLOR;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLabel];
        self.numberLabel = numberLabel;
    }
    return _numberLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:lineView];
        self.lineView = lineView;
    }
    return _lineView;
}

-(void)setLabelTitle:(NSString *)title andNumber:(NSString *)number{
    self.titleLabel.text = title;
    self.numberLabel.text = number;
}

@end


@interface LJCMeHeadView ()
//@property(weak,nonatomic)UILabel *titleLabel;
@property(weak,nonatomic)UILabel *sexAddrLabel;
@property(weak,nonatomic)UIImageView *headImgView;
@property(weak,nonatomic)UIImageView *backgroundImageView;
@property(weak,nonatomic)UIStackView *profileView;
@property(strong,nonatomic)Users *localUser;
@property(weak,nonatomic)UITableView *tableView;
@property(assign,nonatomic)CGFloat initialHeight;
@property(weak,nonatomic)UIVisualEffectView *visualEffectView;


@end

static NSString * const ObservedKeyPath = @"contentOffset";

@implementation LJCMeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = DEFAULT_COLOR;
        [self addSubview:self.sexAddrLabel];
        [self addSubview:self.headImgView];
        [self addSubview:self.profileView];
        @weakify(self)
        [self.sexAddrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.mas_equalTo(self.centerX);
            make.top.equalTo(self.mas_top).offset(10);
            
        }];
        
        [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.centerX.mas_equalTo(self.centerX);
            make.top.equalTo(self.sexAddrLabel.mas_bottom).offset(10);
        }];
        [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.headImgView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
    }
    return self;
}
*/
- (instancetype)initWithTableView:(UITableView *)tableView initialHeight:(CGFloat)height {
    //self = [super initWithFrame:CGRectMake(0, -height, kScreenWidth, height)];
    if (self = [super init]) {
        _tableView = tableView;
        _initialHeight = height;
        //添加观察者
        [_tableView addObserver:self forKeyPath:ObservedKeyPath options:NSKeyValueObservingOptionNew context:nil];
        //[self createSubviews];
    }
    
    return self;
}

-(void)createSubviews{
    //self.backgroundColor = DEFAULT_COLOR;
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.visualEffectView];
    [self addSubview:self.sexAddrLabel];
    [self addSubview:self.headImgView];
    [self addSubview:self.profileView];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        //make.height.mas_equalTo(_initialHeight);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, _initialHeight));
    }];
    [self.visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];
    [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        //make.top.equalTo(self.headImgView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        //make.top.equalTo(self.sexAddrLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.profileView.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [self.sexAddrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        //make.bottom.equalTo(self.headImgView.mas_top).offset(-10);
        make.top.equalTo(self.mas_top).offset(40);
    }];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:ObservedKeyPath]) {
        NSValue *value = change[NSKeyValueChangeNewKey];
        CGPoint contentOffset = value.CGPointValue;
        if (contentOffset.y < -self.initialHeight) {
            CGRect frame = self.backgroundImageView.frame;
            CGFloat height = - contentOffset.y;
            //NSLog(@"%lf", height);
            frame.size.height = height;
            // Aligned background image view's bottom with bottom of its superview
            frame.origin.y = self.initialHeight - height;
            self.backgroundImageView.frame = frame;
            self.visualEffectView.frame = frame;
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)setLocalUser:(Users *)localUser{
    _localUser = localUser;
}

-(UILabel *)sexAddrLabel{
    if (!_sexAddrLabel) {
        UILabel *sexAddrLabel = [UILabel new];
        sexAddrLabel.font = Font(12);
        sexAddrLabel.textColor = WHITE_COLOR;
        //Userinfo *userInfo = _localUser.userinfos[0];
//        Userinfo *userInfo = [Userinfo new];
//        userInfo.userinfo_sex = @"男";
//        userInfo.userinfo_address = @"江苏 南京";
//        sexAddrLabel.text = [NSString stringWithFormat:@"%@ %@",userInfo.userinfo_sex,userInfo.userinfo_address];
        return _sexAddrLabel = sexAddrLabel;
    }
    return _sexAddrLabel;
}

-(UIImageView *)headImgView{
    if (!_headImgView) {
        UIImageView *headImgView = [UIImageView new];
        headImgView.layer.masksToBounds = YES;
        headImgView.layer.cornerRadius = 50;
        headImgView.layer.borderWidth = 2;
        headImgView.layer.borderColor = WHITE_COLOR.CGColor;
        //headImgView.image = [YYImage imageNamed:@"mood_himonoonna_icon_no"];
        return _headImgView = headImgView;
    }
    return _headImgView;
}

-(UIVisualEffectView *)visualEffectView{
    if (!_visualEffectView) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        return _visualEffectView = visualEffectView;
    }
    return _visualEffectView;
}

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0176.jpg"]];
        //UIImageView *backgroundImageView = [[UIImageView alloc] init];
        //backgroundImageView.backgroundColor = UIColorRGBA(0, 101, 68, 1);  //rothko green
        backgroundImageView.backgroundColor = UIColorHex(27b6a4);
        //backgroundImageView.frame = self.bounds;
        backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        /*
        [backgroundImageView addSubview:self.visualEffectView];
        [self.visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(backgroundImageView);
        }];
         */
        return _backgroundImageView = backgroundImageView;
    }
    return _backgroundImageView;
}

-(UIStackView *)profileView{
    if (!_profileView) {
        UIStackView *profileView = [UIStackView new];
        profileView.axis = UILayoutConstraintAxisHorizontal;
        profileView.alignment = UIStackViewAlignmentFill;
        profileView.distribution = UIStackViewDistributionFillEqually;
        profileView.spacing = 0;
        LJCProfileView *weiboView = [LJCProfileView new];
        [weiboView setLabelTitle:@"微博" andNumber:[NSString stringWithFormat:@"%lu",(unsigned long)_localUser.messageses.count]];
        LJCProfileView *followView = [LJCProfileView new];
        [followView setLabelTitle:@"关注" andNumber:[NSString stringWithFormat:@"%lu",(unsigned long)_localUser.messageses.count]];
        LJCProfileView *fansView = [LJCProfileView new];
        [fansView setLabelTitle:@"粉丝" andNumber:[NSString stringWithFormat:@"%lu",(unsigned long)_localUser.messageses.count]];
        NSArray *views = @[weiboView,followView,fansView];
        [views enumerateObjectsUsingBlock:^(LJCProfileView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [profileView addArrangedSubview:obj];
        }];
        return _profileView = profileView;
    }
    return _profileView;
}

-(void)setImageWithImageName:(NSString *)imgName {
    self.headImgView.image = [YYImage imageNamed:imgName];
}

-(void)loadUserInfo:(Users *)user{
    //bug userinfo里是NSDictionary
    NSDictionary *dict = user.userinfos[0];
    Userinfo *userInfo = [Userinfo modelWithDictionary:dict];
    NSArray *headPics = user.pictureses;
    if (headPics.count>0) {
        self.headImgView.image = [YYImage imageNamed:headPics[0]];
    }else{
        self.headImgView.image = [YYImage imageNamed:@"hi"];
    }
    
    self.sexAddrLabel.text = [NSString stringWithFormat:@"%@ %@",userInfo.userinfoSex,userInfo.userinfoAddress];
    [self.profileView reloadInputViews];
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:ObservedKeyPath context:nil];
}
@end
