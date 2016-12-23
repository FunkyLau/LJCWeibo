//
//  PersonalProfileViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/12/13.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "PersonalProfileViewController.h"
#import "Userinfo.h"
#import "UserManager.h"
#import "Users.h"

static CGFloat const FieldHeight = 60.0;
static CGFloat const DatePickerHeight = 120.0;


@interface PersonalProfileViewController ()<UIScrollViewDelegate,UITextFieldDelegate>{
    NSString *birthStr;
}
@property(nonatomic,weak)UIScrollView *mainScrollView;
@property(nonatomic,weak)UITextField *firstNameField;
@property(nonatomic,weak)UITextField *lastNameField;
@property(nonatomic,weak)UITextField *introField;
@property(nonatomic,weak)UITextField *addressNameField;
@property(nonatomic,weak)UIView *datePickerView;
@property(nonatomic,weak)UIButton *commitBtn;


//@property(nonatomic,weak)UIDatePicker *datePicker;
@end

@implementation PersonalProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.gestureRecognizers = nil;
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(40, 0, 0, 0);
        make.edges.mas_equalTo(insets);
    }];
    
    [self.firstNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainScrollView.mas_left).offset(20);
        make.right.equalTo(self.mainScrollView.mas_centerX).offset(-5);
        make.top.equalTo(self.mainScrollView.mas_top).offset(20);
        make.height.mas_equalTo(FieldHeight);
    }];
    [self.lastNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainScrollView.mas_centerX).offset(5);
        make.right.equalTo(self.mainScrollView.mas_right).offset(-20);
        make.top.equalTo(self.mainScrollView.mas_top).offset(20);
        make.height.mas_equalTo(FieldHeight);
    }];
    [self.introField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainScrollView.mas_left).offset(20);
        make.right.equalTo(self.mainScrollView.mas_right).offset(-20);
        make.top.equalTo(self.firstNameField.mas_bottom).offset(20);
        make.height.mas_equalTo(FieldHeight);
    }];
    [self.addressNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainScrollView.mas_left).offset(20);
        make.right.equalTo(self.mainScrollView.mas_right).offset(-20);
        make.top.equalTo(self.introField.mas_bottom).offset(20);
        make.height.mas_equalTo(FieldHeight);
    }];
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainScrollView.mas_left).offset(20);
        make.right.equalTo(self.mainScrollView.mas_right).offset(-20);
        make.top.equalTo(self.addressNameField.mas_bottom).offset(20);
        make.height.mas_equalTo(DatePickerHeight);
    }];
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainScrollView.mas_centerX);
        make.top.equalTo(self.datePickerView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 44));
    }];
    
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        UIScrollView *mainScrollView = [UIScrollView new];
        mainScrollView.delegate = self;
        mainScrollView.scrollEnabled = YES;
        
        [self.view addSubview:mainScrollView];
        self.mainScrollView = mainScrollView;
    }
    return _mainScrollView;
}

-(UITextField *)firstNameField{
    if (!_firstNameField) {
        UITextField *firstNameField = [UITextField new];
        firstNameField.layer.borderWidth = 1;
        firstNameField.tag = 1;
        firstNameField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        firstNameField.delegate = self;
        firstNameField.placeholder = @"  名";
        [self.mainScrollView addSubview:firstNameField];
        self.firstNameField = firstNameField;
    }
    return _firstNameField;
}

-(UITextField *)lastNameField{
    if (!_lastNameField) {
        UITextField *lastNameField = [UITextField new];
        lastNameField.layer.borderWidth = 1;
        lastNameField.tag = 2;
        lastNameField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        lastNameField.delegate = self;
        lastNameField.placeholder = @"  姓";
        [self.mainScrollView addSubview:lastNameField];
        self.lastNameField = lastNameField;
    }
    return _lastNameField;
}

-(UITextField *)introField{
    if (!_introField) {
        UITextField *introField = [UITextField new];
        introField.layer.borderWidth = 1;
        introField.tag = 3;
        introField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        introField.delegate = self;
        introField.placeholder = @"  写一句话介绍自己吧~";
        [self.mainScrollView addSubview:introField];
        self.introField = introField;
    }
    return _introField;
}

-(UITextField *)addressNameField{
    if (!_addressNameField) {
        UITextField *addressNameField = [UITextField new];
        addressNameField.layer.borderWidth = 1;
        addressNameField.tag = 4;
        addressNameField.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        addressNameField.delegate = self;
        addressNameField.placeholder = @"  住址";
        [self.mainScrollView addSubview:addressNameField];
        self.addressNameField = addressNameField;
    }
    return _addressNameField;
}

-(UIView *)datePickerView{
    if (!_datePickerView) {
        UIView *datePickerView = [UIView new];
        UIDatePicker* datePicker = [[UIDatePicker alloc] init];
        datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        datePicker.userInteractionEnabled = YES;
        datePicker.backgroundColor = WHITE_COLOR;
        [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        //设置时区
        [datePicker setTimeZone:[NSTimeZone localTimeZone]];
        [datePicker setDate:[NSDate date]];
        //设置最大显示时间
        [datePicker setMaximumDate:[NSDate date]];
        //仅仅显示日期，不显示时间
        [datePicker setDatePickerMode:UIDatePickerModeDate];
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [datePickerView addSubview:datePicker];
        datePickerView.layer.borderColor = DEFAULT_BACKGROUND_COLOR.CGColor;
        datePickerView.layer.borderWidth = 1;
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(datePickerView);
        }];
        [self.mainScrollView addSubview:datePickerView];
        self.datePickerView = datePickerView;
    }
    return _datePickerView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        commitBtn.layer.masksToBounds = YES;
        commitBtn.layer.cornerRadius = 22;
        commitBtn.backgroundColor = DEFAULT_BTN_COLOR;
        [commitBtn addTarget:self action:@selector(commitProfile) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:commitBtn];
        self.commitBtn = commitBtn;
    }
    return _commitBtn;
}

#pragma mark PivateMethods

- (void)dateChanged:(UIDatePicker *)sender{
    birthStr = [NSString stringWithFormat:@"%@",sender.date];
}

- (void)commitProfile{

    NSString *firstName = self.firstNameField.text;
    NSString *lastName = self.lastNameField.text;
    NSString *introStr = self.introField.text;
    NSString *addrStr = self.addressNameField.text;
    NSString *userId = [NSString stringWithFormat:@"%lu",(unsigned long)_user.usersId];
    if (!firstName || [firstName isEmptyOrBlank]) {
        [PhoneNotification autoHideWithText:@"请输入名字"];
        return;
    }
    if (!lastName || [lastName isEmptyOrBlank]) {
        [PhoneNotification autoHideWithText:@"请输入姓氏"];
        return;
    }
    if (!introStr || [introStr isEmptyOrBlank]) {
        [PhoneNotification autoHideWithText:@"请输入一句话简介"];
        return;
    }
    if (!addrStr || [addrStr isEmptyOrBlank]) {
        [PhoneNotification autoHideWithText:@"请输入地址"];
        return;
    }
    if (!birthStr || [birthStr isEmptyOrBlank]) {
        [PhoneNotification autoHideWithText:@"请选择您的生日"];
        return;
    }
    Userinfo *userInfo = [[Userinfo alloc] init];
    userInfo.usersId = userId;
    userInfo.userinfoRealname = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    userInfo.userinfoIntro = introStr.trim;
    userInfo.userinfoAddress = addrStr.trim;
    userInfo.userinfoBirthday = [birthStr substringToIndex:10];
    [[UserManager sharedInstance] userProfileWithUserInfo:userInfo ifSucceed:^(BOOL succeed, NSString *responseStr) {
        if (succeed) {
            NSLog(@"%@", responseStr);
            [PhoneNotification autoHideWithText:responseStr];
            [self dismissControllerAnimated];
            if ([self.jumpDelegate respondsToSelector:@selector(jumpToLogin)]) {
                [self.jumpDelegate jumpToLogin];
            }
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"11111");
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    switch (textField.tag) {
        case 1:
        {
            if (textField.text.length >= 20) {
                [PhoneNotification autoHideWithText:@"名字少于20个字"];
                return NO;
            }
            break;
        }
        case 2:
        {
            if (textField.text.length >= 20) {
                [PhoneNotification autoHideWithText:@"姓氏少于20个字"];
                return NO;
            }
            break;
        }
        case 3:
        {
            if (textField.text.length >= 40) {
                [PhoneNotification autoHideWithText:@"简介须少于40个字"];
                return NO;
            }
            break;
        }
        case 4:
        {
            if (textField.text.length >= 50) {
                [PhoneNotification autoHideWithText:@"地址须少于50个字"];
                return NO;
            }
            break;
        }
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
