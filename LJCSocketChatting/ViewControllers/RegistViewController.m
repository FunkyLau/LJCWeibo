//
//  RegistViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/10/17.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "RegistViewController.h"
#import "LJCCustomField.h"


@interface RegistViewController ()
@property (nonatomic,weak)LJCCustomField *accountField;
@property (nonatomic,weak)LJCCustomField *passwordField;
@property (nonatomic,weak)LJCCustomField *enterField;
@property (nonatomic,weak)UIButton *loginBtn;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    @weakify(self)
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topView.mas_bottom).offset(30);
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
        [inputView setSecurityMode];
        return _passwordField = inputView;
    }
    return _passwordField;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"注 册" forState:UIControlStateNormal];
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
