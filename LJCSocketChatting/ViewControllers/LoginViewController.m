//
//  LoginViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/9.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LoginViewController.h"
#import "LJCCustomField.h"
#import "UIButton+UIButtonImageWithLable.h"
#import "RegistViewController.h"
#import "UserManager.h"
#import "PersonalProfileViewController.h"

@interface LoginViewController (){
    UserManager *userManager;
}

@property (nonatomic,weak)UIImageView *headIcon;
@property (nonatomic,weak)LJCCustomField *accountField;
@property (nonatomic,weak)LJCCustomField *passwordField;
@property (nonatomic,weak)UIButton *loginBtn;
@property (nonatomic,weak)UIStackView *loginStackView;

@end

@implementation LoginViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    userManager = [UserManager sharedInstance];
    //self.topView.backgroundColor = CLEAR_COLOR;
    [self.topLeftButton setFrame:CGRectMake(10, 10, 30, 20)];
    [self.topLeftButton setImage:nil forState:UIControlStateNormal];
    [self.topLeftButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.topLeftButton addTarget:self action:@selector(closeThisViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.topLeftButton.titleLabel.font = Font(11);
    
    [self.topRightButton setTitle:@"注册" forState:UIControlStateNormal];
    self.topRightButton.titleLabel.font = Font(11);
    [self.topRightButton addTarget:self action:@selector(forwardToRegistView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headIcon];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginBtn];
    //[self.view addSubview:self.loginStackView];
    
//    UIButton *noPwdBtn = [self buttonFactoryWithImageName:@"onepassword-button" andTitle:@"无密登录"];
//    UIButton *wechatBtn = [self buttonFactoryWithImageName:@"detail_share_weixin_session" andTitle:@"微信"];
//    UIButton *QQBtn = [self buttonFactoryWithImageName:@"detail_share_QQ_timeline@2x" andTitle:@"QQ"];
    UIButton *noPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noPwdBtn setImage:[UIImage imageNamed:@"onepassword-button"] withTitle:@"无密登录" forState:UIControlStateNormal];
    [wechatBtn setImage:[UIImage imageNamed:@"detail_share_weixin_session"] withTitle:@"微信" forState:UIControlStateNormal];
    [QQBtn setImage:[UIImage imageNamed:@"detail_share_QQ_timeline@2x"] withTitle:@"QQ" forState:UIControlStateNormal];
    
    
    NSArray *thirdPartLoginArr = @[noPwdBtn,wechatBtn,QQBtn];
    [thirdPartLoginArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = thirdPartLoginArr[idx];
        [self.loginStackView addArrangedSubview:btn];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).dividedBy(3);
        CGSize headSize = CGSizeMake(40, 40);
        make.size.mas_equalTo(headSize);
    }];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headIcon.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountField.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@30);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        //make.bottom.equalTo(self.view).dividedBy(2);
        make.height.equalTo(@35);
    }];
    
    /*
    [self.loginStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_bottom).offset(-80);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    */
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
        [inputView setSecurityMode];
        
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
        [loginBtn addTarget:self action:@selector(loginBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        return _loginBtn = loginBtn;
    }
    return _loginBtn;
}

-(UIStackView *)loginStackView{
    if (!_loginStackView) {
        UIStackView *stackView = [UIStackView new];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.alignment = UIStackViewAlignmentFill;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.spacing = 0;
        //NSArray *thirdPartLoginArr =
        return _loginStackView = stackView;
    }
    return _loginStackView;
}

-(void)forwardToRegistView{
//    RegistViewController *registVC = [RegistViewController new];
//    registVC.controllerState = ControllerStateOnlyLeftButton;
//    [self presentController:registVC];
    
    PersonalProfileViewController *profileVC = [PersonalProfileViewController new];
    profileVC.controllerState = ControllerStateOnlyLeftButton;
    [self presentController:profileVC];
}

-(void)closeThisViewController{
    [self dismissControllerAnimated];
}

-(void)loginBtnPressed{
    NSString *email = [_accountField getInputText];
    NSString *password = [_passwordField getInputText];
    [userManager userLogin:email password:password withCompletionHandler:^(BOOL succeeded, NSDictionary *dicData) {
        if (succeeded) {
            
            [self dismissControllerAnimated];
        }else{
            [PhoneNotification autoHideWithText:dicData[@"result"]];
        }
    }];
}

/*
- (UIButton *)buttonFactoryWithImageName:(NSString *)imgName andTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(40, 60);
    //    在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];//给button添加image
    button.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    
    [button setTitle:title forState:UIControlStateNormal];//设置button的title
    button.titleLabel.font = [UIFont systemFontOfSize:12];//title字体大小
    button.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    [button setTitleColor:GRAY_COLOR forState:UIControlStateNormal];//设置title在一般情况下为灰色字体
    //button.content = UIControlContentVerticalAlignmentCenter;
    button.titleEdgeInsets = UIEdgeInsetsMake(5, -80, -40, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    
    //    [button setContentEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];//
    //button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    
    return button;
}
 */
@end
