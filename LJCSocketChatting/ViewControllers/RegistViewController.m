//
//  RegistViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/10/17.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "RegistViewController.h"
#import "LJCCustomField.h"
#import "UserManager.h"
#import "PersonalProfileViewController.h"
#import "Users.h"

@interface RegistViewController ()<JumpToLoginDelegate>{
    UserManager *manager;
}
@property (nonatomic,weak)LJCCustomField *accountField;
@property (nonatomic,weak)LJCCustomField *passwordField;
@property (nonatomic,weak)LJCCustomField *enterField;
@property (nonatomic,weak)LJCCustomField *nickNameField;
@property (nonatomic,weak)LJCCustomField *verCodeField;
@property (nonatomic,weak)UIImageView *verCodeImageView;
@property (nonatomic,weak)UIButton *loginBtn;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    manager = [UserManager sharedInstance];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.enterField];
    [self.view addSubview:self.nickNameField];
    [self.view addSubview:self.verCodeField];
    [self.view addSubview:self.verCodeImageView];
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
    [self.enterField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.passwordField.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.nickNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.enterField.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.verCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.nickNameField.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        //make.right.equalTo(self.view.mas_right).offset(-100);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    
    [self.verCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameField.mas_bottom).offset(20);
        make.left.equalTo(self.verCodeField.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.verCodeField.mas_bottom).offset(30);
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

-(LJCCustomField *)enterField{
    if (!_enterField) {
        LJCCustomField *inputView = [[LJCCustomField alloc] initWithPlaceHolder:@"请确认密码"];
        [inputView setSecurityMode];
        return _enterField = inputView;
    }
    return _enterField;
}

-(LJCCustomField *)nickNameField{
    if (!_nickNameField) {
        LJCCustomField *inputView = [[LJCCustomField alloc] initWithPlaceHolder:@"请输入昵称"];
        
        return _nickNameField = inputView;
    }
    return _nickNameField;
}

-(LJCCustomField *)verCodeField{
    if (!_verCodeField) {
        LJCCustomField *inputView = [[LJCCustomField alloc] initWithPlaceHolder:@"请输入验证码"];
        //@weakify(self)
//        inputView.setTextLengthBlock = ^(int length){
//            if (length > 4) {
//                inputView.userInteractionEnabled = NO;
//            }
//        };
        return _verCodeField = inputView;
    }
    return _verCodeField;
}

-(UIImageView *)verCodeImageView{
    if (!_verCodeImageView) {
        UIImageView *verView = [UIImageView new];
        NSURL *url = [NSURL URLWithString:kImageCheck];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                verView.image = [YYImage imageWithData:data];
            });
        });
        
        return _verCodeImageView = verView;
    }
    return _verCodeImageView;
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
        [loginBtn addTarget:self action:@selector(registBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        return _loginBtn = loginBtn;
    }
    return _loginBtn;
}
//注册按钮点击
-(void)registBtnPressed{
    NSString *nickName = [self.nickNameField getInputText];
    NSString *email = [self.accountField getInputText];
    NSString *password = [self.passwordField getInputText];
    NSString *verCode = [self.verCodeField getInputText];
    NSLog(@"%@ %@ %@ %@",nickName,email,password,verCode);
    [manager userRegistWithNickName:nickName andPhoneNum:email andPass:password andVerCode:verCode andCompletionHandler:^(BOOL succeeded, NSDictionary *dictData) {
        if (succeeded) {
            //原本是直接返回主界面，现调整为跳转到填写个人资料页
            //[self dismissControllerAnimated];
            NSDictionary *userDict = dictData[@"object"];
            Users *user = [Users modelWithDictionary:userDict];
            PersonalProfileViewController *profileVC = [PersonalProfileViewController new];
            profileVC.controllerState = ControllerStateOnlyLeftButton;
            profileVC.jumpDelegate = self;
            profileVC.user = user;
            [self presentController:profileVC];
        }else{
            NSDictionary *dict = dictData[@"result"];
            NSString *responseStr = dict[@"resDesc"];
            [PhoneNotification autoHideWithText:responseStr];
        }
    }];
}

#pragma mark JumpToLoginDelegate
-(void)jumpToLogin{
    if ([self isKindOfClass:[RegistViewController class]]) {
        [self dismissControllerAnimated];
    }
    
}


@end
