//
//  ShowBigViewController.m
//  testKeywordDemo
//
//  Created by mei on 14-8-18.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "ShowBigViewController.h"
#import "AS_Sheet.h"

@implementation BigImageData


@end

@interface ShowBigViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>

@end

@implementation ShowBigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.selectBigImageArr = [NSMutableArray new];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    //设置导航栏的rightButton
    
    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame=CGRectMake(0, 0, 22, 22);
    [rightbtn setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(OK:)forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
     //设置导航栏的leftButton
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame=CGRectMake(0, 0, 11, 20);
    
    [leftbtn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(dismiss)forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    if([[[UIDevice currentDevice]systemVersion] doubleValue]>=7.0){
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    }
    else{
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
    [self layOut];
    [self showTitle];
}

- (void)showTitle{
    CGFloat pageWidth = _scrollerview.frame.size.width;
    int page = floor((_scrollerview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.title = [NSString stringWithFormat:@"%d/%lu", page + 1, (unsigned long)self.selectBigImageArr.count];
}

-(void)layOut{
    self.view.backgroundColor = [UIColor blackColor];
   
    _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height - 50)];
    _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(244,  _scrollerview.frame.size.height + 9, 61, 32)];
    _scrollerview.pagingEnabled = YES;
    //显示选中的图片的大图
  
    _scrollerview.backgroundColor = GRAY_COLOR;
    _scrollerview.delegate = self;
 
    for (int i=0; i<[self.arrayOK count]; i++) {
        id sender = self.arrayOK[i];
        ALAsset *asset = nil;
        UIImage *tempImg = nil;
        
        if ([sender isKindOfClass:[ALAsset class]]) {
            asset = (ALAsset *)sender;
            tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        else if ([sender isKindOfClass:[UIImage class]]){
            tempImg = (UIImage *)sender;
        }
        if (!tempImg) {
            return;
        }
        BigImageData *bigImageData = [BigImageData new];
        bigImageData.isSelect = YES;
        bigImageData.selectImage = tempImg;
        
        [self.selectBigImageArr addObject:bigImageData];
    }
    
    for (int i=0; i<[self.selectBigImageArr count]; i++) {
        BigImageData *bigImageData = [self.selectBigImageArr objectAtIndex:i];
        UIImageView *imgview=[[UIImageView alloc] initWithFrame:CGRectMake(i*_scrollerview.frame.size.width, 0, _scrollerview.frame.size.width, _scrollerview.frame.size.height)];
        imgview.contentMode=UIViewContentModeScaleAspectFill;
        imgview.clipsToBounds=YES;
        [imgview setImage:bigImageData.selectImage];
        [_scrollerview addSubview:imgview];
    }
    
    _scrollerview.contentSize = CGSizeMake((self.selectBigImageArr.count) * (kScreenWidth),0);
    if (self.index > 0) {
        [_scrollerview setContentOffset:CGPointMake(kScreenWidth * self.index, 0)];
    }
    [self.view addSubview:_scrollerview];
    
    //[_btnOK setBackgroundImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
    [_btnOK setBackgroundColor:DEFAULT_BTN_COLOR];
    [_btnOK.layer setMasksToBounds:YES];
    [_btnOK.layer setCornerRadius:4];
    [_btnOK setTitle:[NSString stringWithFormat:@"完成(%lu)",(unsigned long)self.selectBigImageArr.count] forState:UIControlStateNormal];
//    [_btnOK setTitle:@"完成" forState:UIControlStateNormal];
    _btnOK .titleLabel.font = [UIFont systemFontOfSize:10];
    [_btnOK addTarget:self action:@selector(doneSelectBt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnOK];    
}

- (void)doneSelectBt{
    NSInteger jj = 0;
    for (int i = 0; i < self.selectBigImageArr.count; i++) {
        BigImageData *bigImageData = [self.selectBigImageArr objectAtIndex:i];
        
        if (!bigImageData.isSelect) {
            jj++;
        }
    }
    if (_arrayOK.count == _selectBigImageArr.count - jj) {
        [self complete:nil];
    }
    else{
        AS_Sheet *_sheet = [[AS_Sheet alloc] initWithFrame:self.view.bounds titleArr:@[@"确定",[NSString stringWithFormat:@"已取消%lu张图", (long)jj]]];
//        LXActionSheet *loginOutSheet = [[LXActionSheet alloc] initWithTitle: delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"确定"]];
        //[loginOutSheet showInView:self.view];
        _sheet.tag = 2;
        @weakify(_sheet);
        _sheet.Click = ^(NSInteger clickIndex) {
            @strongify(_sheet);
            if (!self) {
                return;
            }
            switch (clickIndex) {
                case 0:
                    NSLog(@"确定");
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                case 1:
                    NSLog(@"%@",[NSString stringWithFormat:@"已取消%lu张图", (long)jj]);
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                default:
                    break;
            }
            [_sheet hiddenSheet];
        };
        [self.view addSubview:_sheet];
        
    }
}

-(void)complete:(UIButton *)sender{
    [self.arrayOK removeAllObjects];
    for (BigImageData *bigImageData in self.selectBigImageArr) {
        if (bigImageData.isSelect) {
            [self.arrayOK addObject:bigImageData.selectImage];
        }
    }
    if ([_delegate respondsToSelector:@selector(selectedImageDone:)]) {
        [_delegate selectedImageDone:self.arrayOK];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.barTintColor = WHITE_COLOR;
    [[UINavigationBar appearance]setTintColor:[UIColor blueColor]];

    
    if (self.isCameraIn) {
        //[self.navigationController popToRootViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        [self dismissViewControllerAnimated:YES completion:Nil];
}

-(void)OK:(UIButton *)sender{
    CGFloat pageWidth = _scrollerview.frame.size.width;
    int page = floor((_scrollerview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page > self.selectBigImageArr.count) {
        return;
    }
    
    BigImageData *bigImageData = (BigImageData *)[self.selectBigImageArr objectAtIndex:page];
    if (bigImageData.isSelect) {
        [rightbtn setImage:[UIImage imageNamed:@"camera_btn_ok.png"] forState:UIControlStateNormal];
    }
    else
    {
        [rightbtn setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    }
    bigImageData.isSelect = !bigImageData.isSelect;
    
    NSInteger count = 0;
    
    for (BigImageData *bigImage in self.selectBigImageArr) {
        if (bigImage.isSelect) {
            count++;
        }
    }
    [_btnOK setTitle:[NSString stringWithFormat:@"完成(%ld)", (long)count] forState:UIControlStateNormal];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = _scrollerview.frame.size.width;
    int page = floor((_scrollerview.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page > self.selectBigImageArr.count || self.selectBigImageArr.count == 0) {
        return;
    }
    BigImageData *bigImageData = (BigImageData *)[self.selectBigImageArr objectAtIndex:page];
    if (bigImageData.isSelect) {
        [rightbtn setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    }
    else
    {
        [rightbtn setImage:[UIImage imageNamed:@"camera_btn_ok.png"] forState:UIControlStateNormal];
    }
    [self showTitle];
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
//    UIColor *red = [UIColor colorWithRed:255/255.0 green:48/255 blue:48/255 alpha:0.7];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.barTintColor = WHITE_COLOR;
    [[UINavigationBar appearance]setTintColor:[UIColor blueColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LXActionSheetDelegate
- (void)didClickOnButtonIndex:(NSInteger)buttonIndex andId:(id)sender{
    if (0 == buttonIndex) {
        [self complete:nil];
    }
}

@end
