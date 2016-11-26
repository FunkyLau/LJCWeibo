//
//  LeftViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/11/18.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LeftViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface LeftViewController (){
    BOOL isClicked;
    NSArray *channelArr;
}

@property (nonatomic,weak) UIImageView *bgImageView;
@property (nonatomic,weak) UIImageView *headImageView;
//@property (nonatomic,weak) UIStackView *channelStackView;
@property (nonatomic,weak) UIScrollView *leftScrollView;
@property (nonatomic,weak) UIVisualEffectView *visualEffectView;


@end



@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    channelArr = @[@"全部",@"原创微博",@"特别关注",@"明星",@"同学",@"同事",@"朋友"];
    [self addAllSubviews];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAllSubviews{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //UIEdgeInsets inset = UIEdgeInsetsMake(0,0,0,0);
        make.edges.equalTo(self.view);
    }];
    //    [self.visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.bgImageView);
    //    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [self.leftScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}


- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        UIImageView *bgImageView = [UIImageView new];
        //bgImageView.image = [YYImage imageNamed:@"login_bg_top"];
        bgImageView.backgroundColor = DEFAULT_BTN_COLOR;
        [self.view addSubview:bgImageView];
        self.bgImageView = bgImageView;
    }
    return _bgImageView;
}

-(UIVisualEffectView *)visualEffectView{
    if (!_visualEffectView) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [self.view addSubview:visualEffectView];
        self.visualEffectView = visualEffectView;
    }
    return _visualEffectView;
}

-(UIScrollView *)leftScrollView{
    if (!_leftScrollView) {
        UIScrollView *leftScrollView = [UIScrollView new];
        leftScrollView.showsVerticalScrollIndicator = NO;
        UIStackView *channelStackView = [UIStackView new];
        channelStackView.axis = UILayoutConstraintAxisVertical;
        channelStackView.alignment = UIStackViewAlignmentCenter;
        channelStackView.distribution = UIStackViewDistributionFill;
        channelStackView.spacing = 5;
        //channelStackView.layoutMarginsRelativeArrangement = YES;
        [leftScrollView addSubview:channelStackView];
        [channelStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(leftScrollView);
        }];
        [channelArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *channelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //channelBtn.frame = CGRectMake(10, 0, 180, 50);
            //channelBtn.height = 50;
            channelBtn.titleLabel.font = Font(18);
            [channelBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
            [channelBtn setTitle:obj forState:UIControlStateNormal];
            channelBtn.backgroundColor = CLEAR_COLOR;
            [channelBtn addTarget:self action:@selector(searchGroupWeibo:) forControlEvents:UIControlEventTouchUpInside];
            [channelStackView addArrangedSubview:channelBtn];
            [channelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(channelStackView.mas_left).offset(10);
                make.right.equalTo(channelStackView.mas_right).offset(-10);
                make.height.mas_equalTo(40);
                make.width.mas_equalTo(kScreenWidth/2-20);
                channelBtn.layer.masksToBounds = YES;
                channelBtn.layer.cornerRadius = 20;
            }];
        }];
        
        [self.view addSubview:leftScrollView];
        self.leftScrollView = leftScrollView;
    }
    return _leftScrollView;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        UIImageView *headImageView = [UIImageView new];
        headImageView.image = [YYImage imageNamed:@"hi"];
        headImageView.layer.shadowOpacity = 0.5;
        headImageView.layer.shadowColor = GRAY_COLOR.CGColor;
        headImageView.layer.shadowRadius = 3;
        headImageView.layer.shadowOffset = CGSizeMake(1, 1);
        [self.view addSubview:headImageView];
        self.headImageView = headImageView;
    }
    return _headImageView;
}

- (void)searchGroupWeibo:(UIButton *)pressedBtn{
    //将点按的button置为模糊
    pressedBtn.backgroundColor = LEFT_BTN_COLOR;
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [pressedBtn addSubview:visualEffectView];
    
}

@end
