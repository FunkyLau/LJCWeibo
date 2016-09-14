//
//  LoginViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/9.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LoginViewController.h"
#import "LJCCustomField.h"


@interface LoginViewController ()

@property (nonatomic,weak)UIImageView *headIcon;
@property (nonatomic,weak)LJCCustomField *accountField;
@property (nonatomic,weak)LJCCustomField *passwordField;
@property (nonatomic,weak)UIButton *loginBtn;
@property (nonatomic,weak)UIStackView *loginStackView;

@end

@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.topView.backgroundColor = CLEAR_COLOR;
    [self.topLeftButton setImage:nil forState:UIControlStateNormal];
    [self.topLeftButton setTitle:@"关闭" forState:UIControlStateNormal];
    self.topLeftButton.titleLabel.font = Font(11);
    
    [self.topRightButton setTitle:@"注册" forState:UIControlStateNormal];
    self.topRightButton.titleLabel.font = Font(11);
    
    [self.view addSubview:self.headIcon];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    @weakify(self)
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).dividedBy(3);
        CGSize headSize = CGSizeMake(40, 40);
        make.size.mas_equalTo(headSize);
    }];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headIcon.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.accountField.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.passwordField.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.bottom.equalTo(self.view).dividedBy(2);
        make.height.equalTo(@35);
    }];
}

-(UIImageView *)headIcon{
    if (!_headIcon) {
        UIImageView *headImg = [UIImageView new];
        //headImg.image = [YYImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ww1.sinaimg.cn/mw690/591cb086jw1f7n3lsr2tbj20u00u00vu.jpg"]]];
        //http://ww1.sinaimg.cn/mw690/591cb086jw1f7n3lsr2tbj20u00u00vu.jpg
        
        headImg.image = IMAGE_No_Cache(@"mood_himonoonna_icon_no");
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius = 20;
        return _headIcon = headImg;
    }
    return _headIcon;
}

-(LJCCustomField *)accountField{
    if (!_accountField) {
        LJCCustomField *inputView = [[LJCCustomField alloc] initWithPlaceHolder:@"请输入邮箱"];
        
        
        return _accountField = inputView;
    }
    return _accountField;
}

-(LJCCustomField *)passwordField{
    if (!_passwordField) {
        LJCCustomField *inputView = [[LJCCustomField alloc] initWithPlaceHolder:@"请输入密码"];
        
        
        return _passwordField = inputView;
    }
    return _passwordField;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = Font(13);
        [loginBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = 4;
        loginBtn.backgroundColor = DEFAULT_COLOR;
        return _loginBtn = loginBtn;
    }
    return _loginBtn;
}
@end
