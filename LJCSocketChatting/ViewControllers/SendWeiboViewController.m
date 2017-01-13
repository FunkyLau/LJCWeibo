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
#import "MGPhotoCollectionView.h"
#import "GDHGlobalUtil.h"
#import "MGPhotoViewController.h"
#import "Messages.h"

@interface SendWeiboViewController ()<UITextViewDelegate,MGPhotoCollectionViewDelegate>{
    NSInteger typeNum;
    MessageManager *messageManager;
}
@property (nonatomic,weak)UITextView *inputTextView;
//@property (nonatomic,weak)UITextField *inputField;
@property (nonatomic,weak)UIStackView *inputToolsStackView;
@property (nonatomic,weak)UILabel *typeNumLabel;
//@property (weak, nonatomic)MGPhotoCollectionView *collectionView;
@property (weak, nonatomic)NSLayoutConstraint *collectionViewLayoutHeight;
/**当前照片容器的数据源数组**/
//@property (nonatomic, strong) NSMutableArray <MGPhotoModel *>* currentPhotoArray;

@property (nonatomic, weak) MGPhotoCollectionView * daimaCollectionView;
@property (nonatomic, strong) NSMutableArray <MGPhotoModel *>* daimaCurrentPhotoArray;
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
    [self.daimaCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.inputTextView.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
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
#pragma mark ====== // 懒加载 \\ ========
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


//-(NSMutableArray<MGPhotoModel *> *)currentPhotoArray{
//    if (_currentPhotoArray == nil) {
//        _currentPhotoArray = [NSMutableArray array];
//    }
//    return _currentPhotoArray;
//}
-(NSMutableArray<MGPhotoModel *> *)daimaCurrentPhotoArray {
    if (_daimaCurrentPhotoArray == nil) {
        _daimaCurrentPhotoArray = [NSMutableArray array];
    }
    return _daimaCurrentPhotoArray;
}

-(MGPhotoCollectionView *)daimaCollectionView {
    if (_daimaCollectionView == nil) {
        //_daimaCollectionView = [[MGPhotoCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/2, CGRectGetHeight(self.view.frame), 0) withLineCounts:6];
        MGPhotoCollectionView *daimaCollectionView = [[MGPhotoCollectionView alloc] initWithFrame:CGRectZero withLineCounts:3];
        daimaCollectionView.delegate = self;
        [self.view addSubview:daimaCollectionView];
        self.daimaCollectionView = daimaCollectionView;
    }
    return _daimaCollectionView;
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
    
    [messageManager sendMessageWithUserId:userIdStr andMessageInfo:self.inputTextView.text andCompletionHandler:^(BOOL succeeded, NSDictionary *messagesDict) {
        if (succeeded) {
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            Messages *message = [Messages modelWithJSON:messagesDict];
            NSString *messageId = message.messagesId;
            
            ///Users/jiachenliu/Library/Developer/CoreSimulator/Devices/9570EAF3-4B9F-49B5-8824-D896710014FF/data/Containers/Data/Application/69B79849-FD8E-4C76-8853-92C4AE1DD083/Documents/User
            [self.daimaCurrentPhotoArray enumerateObjectsUsingBlock:^(MGPhotoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImage *image = obj.image;
                NSString *imageName = [NSString stringWithFormat:@"%@_%lu.png",messageId,idx];
                //NSString *imagePath = [NSString stringWithFormat:@"%@/%@",[PathUtil rootPathOfUser],imageName];
                NSString *imagePath = [[PathUtil rootPathOfUser] stringByAppendingPathComponent:imageName];
                NSLog(@"%@", imagePath);
                [messageManager saveImage:image WithName:imagePath];
                [messageManager uploadWeiboPicturesWithMessageId:messageId andImageName:(NSString *)imageName andImagePath:imagePath andCompletionHandler:^(BOOL succeeded, NSDictionary *dicData) {
                    if (succeeded) {
                        NSLog(@"%@",dicData);
                    }
                }];
            }];
            
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

#pragma mark ToolBarMethods
-(void)showCameraView:(UIButton *)button{
    
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

#pragma mark MGPhotoCollectionViewDelegate
//========= 1. 添加图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView addPhotoArray:(NSMutableArray <MGPhotoModel *> *)photoArray {
    [self.daimaCurrentPhotoArray removeAllObjects];
    [self.daimaCurrentPhotoArray addObjectsFromArray:photoArray];
    [[GDHGlobalUtil ShareGDHGlobalUtil] TransferCameraWithViewController:self ImageBlock:^(UIImage *image) {
        MGPhotoModel * photo = [MGPhotoModel CreateModelWithIcon:@"" withType:2 withImage:image withIsDelete:NO withIsModelType:NO];
        [self.daimaCurrentPhotoArray addObject:photo];
        self.daimaCollectionView.dataArray = self.daimaCurrentPhotoArray;
    }];
}
//========= 2.点击图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView clickIndex:(NSInteger)index photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray {
    if (photoArray.count > 0) {
        MGPhotoViewController * vc = [[MGPhotoViewController alloc] init];
        vc.dataArray = photoArray;
        vc.clickIndex = index;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }else{
    }
}

//==========3.是否处于删除状态
-(void)collectionView:(MGPhotoCollectionView *)collectionView isDeleteState:(BOOL)state photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray {
    
}

/**
 点击删除按钮时 返回数据源及下一个按钮
 
 @param collectionView MGPhotoCollectionView对象
 @param photoArray 数据源数组
 @param nextIndex 下一个数组
 */
-(void)collectionView:(MGPhotoCollectionView *)collectionView photoArray:(NSMutableArray <MGPhotoModel *>*)photoArray nextIndex:(NSInteger)nextIndex {
    
}

@end
