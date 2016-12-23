//
//  SendWeiboViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/27.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//  发微博入口VC

#import "SendWeiboViewController.h"
#import "MessageManager.h"
#import "Users.h"
#import "UserManager.h"

@interface SendWeiboViewController ()<UITextViewDelegate>{
    NSInteger typeNum;
    MessageManager *messageManager;
}
@property (nonatomic,weak)UITextView *inputTextView;
//@property (nonatomic,weak)UITextField *inputField;
@property (nonatomic,weak)UIStackView *inputToolsStackView;
@property (nonatomic,weak)UILabel *typeNumLabel;
@end

@implementation SendWeiboViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //atypeNum = 140;
    //[self.topLeftButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.topLeftButton addTarget:self action:@selector(closeSendingWindow) forControlEvents:UIControlEventTouchUpInside];
    [self.topRightButton setTitle:@"发送" forState:UIControlStateNormal];
    self.topRightButton.titleLabel.font = Font(14);
    [self.topRightButton addTarget:self action:@selector(sendWeibo) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(100);
        //make.bottom.equalTo(self.inputToolsStackView);
    }];
    /*
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(100);
        //make.bottom.equalTo(self.inputToolsStackView);
    }];
     */
    [self.inputToolsStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    if (!messageManager) {
        messageManager = [MessageManager sharedInstance];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}
/*
- (UITextField *)inputField{
    if (!_inputField) {
        UITextField *inputField = [UITextField new];
        inputField.placeholder = @"写微博...";
        inputField.delegate = self;
        //inputField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:inputField];
        self.inputField = inputField;
    }
    return _inputField;
}
*/

-(UITextView *)inputTextView{
    if (!_inputTextView) {
        UITextView *inputView = [UITextView new];
        inputView.font = Font(14);
        inputView.textColor = GRAY_COLOR;
        inputView.delegate = self;
        [self.view addSubview:inputView];
        self.inputTextView = inputView;
    }
    return _inputTextView;
}
 
- (UIStackView *)inputToolsStackView{
    if (!_inputToolsStackView) {
        UIButton *cameraBtn = [self createInputToolWithImageName:@"compose_toolbar_1"];
        UIButton *hashTagBtn = [self createInputToolWithImageName:@"compose_toolbar_4"];
        UIButton *emojiBtn = [self createInputToolWithImageName:@"compose_toolbar_6"];
        UIButton *moreBtn = [self createInputToolWithImageName:@"compose_toolbar_5"];
        NSArray *inputToolSubViews = @[cameraBtn,hashTagBtn,emojiBtn,moreBtn,self.typeNumLabel];
        UIStackView *inputToolsStackView = [[UIStackView alloc] initWithArrangedSubviews:inputToolSubViews];
        inputToolsStackView.axis = UILayoutConstraintAxisHorizontal;
        inputToolsStackView.alignment = UIStackViewAlignmentFill;
        inputToolsStackView.distribution = UIStackViewDistributionFillEqually;
        inputToolsStackView.spacing = 10;
        [self.view addSubview:inputToolsStackView];
        //self.inputField.inputAccessoryView = inputToolsStackView;
        self.inputToolsStackView = inputToolsStackView;
    }
    
    return _inputToolsStackView;
}


- (UILabel *)typeNumLabel{
    if (!_typeNumLabel) {
        UILabel *typeNumLabel = [UILabel new];
        [typeNumLabel setTextColor:GRAY_COLOR];
        [typeNumLabel setFont:Font(12)];
        
        [self.view addSubview:typeNumLabel];
        self.typeNumLabel = typeNumLabel;
    }
    return _typeNumLabel;
}

- (UIButton *)createInputToolWithImageName:(NSString *)imgName{
    UIImage *image = [YYImage imageNamed:imgName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundColor:CLEAR_COLOR];
    
    return btn;
}

- (void)changeContentViewPoint:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    //获取键盘弹出后的键盘视图所在Y坐标
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    //添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.inputToolsStackView.center = CGPointMake(self.inputToolsStackView.centerX, keyBoardEndY-self.topBarHeight-self.inputToolsStackView.bounds.size.height/2.0);//keyBoardEndY的坐标包含了状态栏的高度，要减去
    }];
}

- (void)closeSendingWindow{
    [self dismissControllerAnimated];
}

- (void)sendWeibo{
    Users *loginUser = [[UserManager sharedInstance] loginedUser];
    NSString *userIdStr = [NSString stringWithFormat:@"%ld",loginUser.usersId];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [messageManager sendMessageWithUserId:userIdStr andMessageInfo:self.inputTextView.text andCompletionHandler:^(BOOL succeeded, NSString *response) {
        if (succeeded) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self closeSendingWindow];
        }
    }];
    
    /*
    [messageManager sendMessageWithUserId:userIdStr andMessageInfo:self.inputField.text andCompletionHandler:^(BOOL succeeded, NSString *response) {
        if (succeeded) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self closeSendingWindow];
        }
    }];
     */
}

#pragma mark UITextFieldDelegate
/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length + range.location > textField.text.length) {
        
        return NO;
    }
    NSUInteger inputLength = [textField.text length] + [string length] - range.length;
    typeNum = 140-inputLength;
    self.typeNumLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)typeNum];
    if (typeNum <= 0) {
        [PhoneNotification autoHideWithText:@"不可以再输入了哦~"];
    }
    return inputLength < 140;
}

*/
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.length + range.location > textView.text.length) {
        
        return NO;
    }
    NSUInteger inputLength = [textView.text length] + [text length] - range.length;
    typeNum = 140-inputLength;
    self.typeNumLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)typeNum];
    if (typeNum <= 0) {
        [PhoneNotification autoHideWithText:@"不可以再输入了哦~"];
    }
    return inputLength < 140;
    
}

@end
