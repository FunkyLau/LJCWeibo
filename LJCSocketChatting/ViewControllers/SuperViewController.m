//
//  SuperViewController.m
//  DHTalentReward
//
//  Created by shengzhong on 15/5/27.
//  Copyright (c) 2015年 szwl. All rights reserved.
//

#import "SuperViewController.h"
//#import "AppDelegate.h"



#define kAnimateTime 0.4f
#define kStartX -200                // 背景视图起始frame.x
#define kTopToolsBtnWidthArea 80.f  // 工具栏按钮宽度区域
#define DHLabelFont [UIFont fontWithName:@"Helvetica-Bold" size:16]



@interface SuperViewController () <UIViewControllerTransitioningDelegate>{
    
    CGFloat             _topBarCenterY;     // 顶部工具栏中心位置(Y)
    __weak UILabel      *_titleLabel;
    __weak UIActivityIndicatorView *_indicator;
    
    
    // errorView;
    __weak UILabel *_errTitle;
    __weak UIButton *_errRefresh;
    
    //下拉刷新动画图片
    NSMutableArray *pullAnimationImages;
    NSMutableArray *shakeAnimationImages;
}

// controller 转场动画切换属性
@property(nonatomic,strong) PresentAnimation *presentAnim;
@property(nonatomic,strong) DismissAnimation *dismissAnim;
@property(nonatomic,strong) SliderRightInteractiveTransition *sliderInteractive;


@end



@implementation SuperViewController
@synthesize width;
@synthesize height;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}
-(void)initData {
     
    // controller 之间切换
    _presentAnim = [PresentAnimation new];
    _dismissAnim = [DismissAnimation new];
    [self setTransitioningDelegate:self];
}


// 初始化顶部工具栏View
-(void)initTopToolsBar {
    
    if (!(_controllerState & DHCtrlState_TopBar)) {
        return;
    }
    
    CGRect topR = CGRectMake(0, 0, kScreenWidth, _topBarHeight);
    UIView *topToolsV = [[UIView alloc] initWithFrame:topR];
    _topView = topToolsV;
    topToolsV.backgroundColor = DEFAULT_COLOR;
    [self.view addSubview:topToolsV];
    
    // 左边返回按钮
    if (_controllerState & DHCtrlState_TopBar_LBtn_GoBack ||
        _controllerState & DHCtrlState_TopBar_LBtn_Menu) {
        
        UIImage *btnImage = [UIImage imageNamed:@"button_back"];
        if (_controllerState & DHCtrlState_TopBar_LBtn_Menu) {
//            btnImage = [YYImage imageNamed:@"button_icon_group"];
            btnImage = [UIImage imageWithSize:CGSizeMake(34, 34) drawBlock:^(CGContextRef context) {
                [btnImage drawInRect:CGRectMake(0, 0, 34, 34) withContentMode:UIViewContentModeScaleAspectFill clipsToBounds:YES];
            }];
        }
        
        UIButton *leftBtn = [UIButton new];
        _topLeftButton = leftBtn;
        [leftBtn setSize:CGSizeMake(30, 30)];
        [leftBtn setImage:btnImage forState:UIControlStateNormal];
        [leftBtn addTarget:self
                    action:@selector(topToolsBarLeftButtonClick)
          forControlEvents:UIControlEventTouchUpInside];
        //[leftBtn sizeToFit];
        leftBtn.center = CGPointMake(kTopToolsBtnWidthArea/2.f-15, _topBarCenterY+10);
        
 
        // 设置按钮点击扩大范围
        [leftBtn setEnlargeEdgeWithTop:20 right:30
                                bottom:10 left:10];
        [topToolsV addSubview:leftBtn];
    }
    
    // 初始化子控件(标题控件)
    if (_controllerState & DHCtrlState_TopBar_Title) {
        UILabel *titleL = [UILabel new];
        _titleLabel = titleL;
        titleL.font = DHLabelFont;
        [titleL setTextColor:WHITE_COLOR];
        [titleL setTextAlignment:NSTextAlignmentCenter];
        titleL.lineBreakMode = NSLineBreakByClipping;
        titleL.center = CGPointMake(topToolsV.center.x, _topBarCenterY+10);
        titleL.userInteractionEnabled = NO;
        [topToolsV addSubview:titleL];
        
        if (self.title && ![self.title isEmptyOrBlank]) {
            [self setTitle:self.title];
        }
    }
    
    // 右边功能按钮
    if (_controllerState & DHCtrlState_TopBar_RBtn){
        
//        UIImage *btnImage = [YYImage imageNamed:@"mask_timeline_top_icon_2"];
//        btnImage = [UIImage imageWithSize:CGSizeMake(34, 34) drawBlock:^(CGContextRef context) {
//            [btnImage drawInRect:CGRectMake(0, 0, 34, 34) withContentMode:UIViewContentModeScaleAspectFill clipsToBounds:YES];
//        }];
        
        UIButton *messageBt = [UIButton buttonWithType:UIButtonTypeCustom];
        //[messageBt setImage:btnImage forState:UIControlStateNormal];
        _topRightButton = messageBt;
        
        messageBt.backgroundColor = [UIColor clearColor];
        [messageBt setTitle:@"" forState:UIControlStateNormal];
        //[messageBt.titleLabel setFont:[UIFont systemFontOfSize:12]];
        //[messageBt sizeToFit];
        [messageBt setSize:CGSizeMake(30, 30)];
        messageBt.center = CGPointMake(self.width-kTopToolsBtnWidthArea/2.f+15, _topBarCenterY+10);
        [messageBt setEnlargeEdgeWithTop:messageBt.frame.origin.y
                                   right:fabs(kTopToolsBtnWidthArea-messageBt.width)/2
                                  bottom:topToolsV.height-messageBt.frame.origin.y-messageBt.height
                                    left:fabs(kTopToolsBtnWidthArea-messageBt.width)/2];
        [topToolsV addSubview:messageBt];
        
    }
    // 中间为搜索栏
    if (_controllerState & DHCtrlState_SearchBar) {
        /*
        UIView *searchView = [UIView new];
        searchView.frame = CGRectMake(20, 10, kScreenWidth-40, 25);
        //searchView.size = CGSizeMake(kScreenWidth-80, 25);
        UIImageView *searchIcon = [UIImageView new];
        searchIcon.image = [UIImage imageNamed:@"profile_search_icon"];
        UILabel *searchLabel = [UILabel new];
        searchLabel.text = @"搜索";
        searchLabel.font = Font(12);
        searchIcon.frame = CGRectMake(CGRectGetWidth(searchView.frame)/2-15, 6, 15, 15);
        searchLabel.frame = CGRectMake(CGRectGetMaxX(searchIcon.frame), 6, searchLabel.intrinsicContentSize.width, searchLabel.intrinsicContentSize.height) ;
        [searchView addSubview:searchIcon];
        [searchView addSubview:searchLabel];
        searchView.layer.masksToBounds = YES;
        searchView.layer.cornerRadius = 12.5;
        _searchView = searchView;
        searchView.backgroundColor = UIColorRGBA(40, 102, 194, 1);
        [topToolsV addSubview:searchView];
         */
    }
    
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    if (_titleLabel) {
        _titleLabel.text = title;
        
        CGPoint tempCenter = _titleLabel.center;
        CGFloat maxWidth = self.width - kTopToolsBtnWidthArea-20;
        CGSize tSize = [_titleLabel sizeThatFits:CGSizeZero];
        if (tSize.width > maxWidth) {
            tSize.width = maxWidth;
        }
        
        _titleLabel.frame = CGRectMake(0, 0, tSize.width, tSize.height);
        _titleLabel.center = tempCenter;
    }
}

-(void)setTitileFont:(UIFont*)font{
    
    if (_titleLabel) {
        _titleLabel.font = font;
        CGPoint tempCenter = _titleLabel.center;
        CGFloat maxWidth = self.width - kTopToolsBtnWidthArea-20;
        CGSize tSize = [_titleLabel sizeThatFits:CGSizeZero];
        if (tSize.width > maxWidth) {
            tSize.width = maxWidth;
        }
        
        _titleLabel.frame = CGRectMake(0, 0, tSize.width, tSize.height);
        _titleLabel.center = tempCenter;
    }
}

// controller view 高宽
-(CGFloat)width {
    return CGRectGetWidth(self.view.bounds);
}
-(CGFloat)height {
    return CGRectGetHeight(self.view.bounds);
}

-(CGFloat)centerX {
    return self.view.centerX;
}
-(CGFloat)centerY {
    return self.view.centerY;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // 背景颜色
    CGRect bgR = CGRectMake(0, 0, self.width, self.height);
    _bgView = [[UIView alloc] initWithFrame:bgR];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view insertSubview:_bgView atIndex:0];
    
    
    // 初始化顶部工具栏及子控件
    _topBarHeight = topToolBarHeight;
    //_topBarCenterY = 22 + (_topBarHeight-22) / 2.f;
    _topBarCenterY = _topBarHeight/ 2.f;
    if(_controllerState == DHCtrlState_None) {
        _topBarHeight = 0;
        _topBarCenterY = 0;
    }
   //初始化顶部工具栏
    [self initTopToolsBar];
    

    // 添加手势
    if (self.controllerState & DHCtrlState_GestureGoBack) {
        self.sliderInteractive = [[SliderRightInteractiveTransition alloc] initWithController:self];
    }
    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (_indicator) {
        CGFloat vW = self.view.width;
        CGFloat vH = self.view.height;
        _indicator.center = CGPointMake(vW/2., vH/2.-30);
    }
}

- (void)clickMessageBt{
    
}

/**
 *  返回
 */
- (void)goBack {
    [self dismissControllerAnimated];
}
- (void)topToolsBarLeftButtonClick {
    if (_controllerState & DHCtrlState_TopBar_LBtn_GoBack) {
        [self goBack];
    }
}

- (void)rightButtonClick {
    
}

// 手势返回的处理函数
- (void)didBackGestureEndHandle{
    
}

- (void)presentController:(UIViewController *)viewController
{
    //切换试图
    [super presentViewController:viewController animated:YES completion:nil];
}

- (void)dismissControllerAnimated {
    
    // _ismoving 表示是手势返回过来的
//    if (_isMoving) {
//        [super dismissViewControllerAnimated:NO completion:nil];
//    }
//    else{
//        [super dismissViewControllerAnimated:YES completion:nil];
//    }
//    
    [super dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  显示顶部右边按钮
 */
- (void)showRightButton:(UIButton *)rightButton {
    
    if (!rightButton) {
        return;
    }
    
    [_topRightButton removeFromSuperview];
    _topRightButton = nil;
    _topRightButton = rightButton;

    _topRightButton.center = CGPointMake(self.width-kTopToolsBtnWidthArea/2, _topBarCenterY);
    [_topView addSubview:rightButton];
    
    CGFloat r = kTopToolsBtnWidthArea-rightButton.width/2;
    CGFloat b = _topBarHeight-rightButton.frame.origin.y-rightButton.height;
    r = r > 0 ? r : 0;
    b = b > 0 ? b : 0;
    [rightButton setEnlargeEdgeWithTop:rightButton.frame.origin.y
                             right:r bottom:b left:r];
}



// 默认显示“加载异常”
- (void)showErrorView:(NSString*)errorTitle
         refreshEvent:(void (^)())block {
    
    if (_errTitle == nil || _errRefresh == nil) {
        
        NSString *titleStr = @"数据加载失败";
        if (errorTitle && ![errorTitle isEmptyOrBlank]) {
            titleStr = errorTitle;
        }
        
        
        UILabel *lab = [UILabel new];
        lab.font = sysFont(13);
        lab.textColor = PDTDSCR_COLOR;
        lab.text = titleStr;
        [self.view addSubview:_errTitle=lab];
        [lab sizeToFit];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.centerY.equalTo(self.view).with.offset(-50);
        }];
        
        
        // button
        @weakify(self)
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 100, 30);
        [btn setTitle:@"刷新" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIImage *enableImage = [UIImage imageWithColor:buttonSelectedColor size:btn.size];
        [btn setBackgroundImage:enableImage forState:UIControlStateNormal];
        [btn setCornerRadius:4];
        btn.titleLabel.font = sysFont(15);
        [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender){
            
            @strongify(self)
            if (!self) return;
            [self hidderErrorView];
        
            if (block) block();
          
        }];
        [self.view addSubview:_errRefresh=btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.centerY.equalTo(self.view).with.offset(-20);
        }];
    }

}
- (void)hidderErrorView {
    [_errTitle removeFromSuperview];
    [_errRefresh removeFromSuperview];
    _errTitle = nil;
    _errRefresh = nil;
}

#pragma mark - 点击事情
- (void)moveViewWithX:(float)x
{
    x = x < 0 ? 0 : x;
    x = x > kScreenWidth ? kScreenWidth : x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float alpha = 0.4 - (x/800);
    _blackMask.alpha = alpha;
    
    CGFloat aa = fabsf(_startBackViewX) / kScreenWidth;
    CGFloat moveX = x * aa;
    CGFloat lastScreenShotViewHeight = kScreenHeight;
    [_lastScreenShotView setFrame:CGRectMake(_startBackViewX+moveX, 0,
                                             kScreenWidth,
                                             lastScreenShotViewHeight)];
    
}



// 工具函数
-(void)showLoadingUI:(BOOL)show {
    
    if (show) {
        if (!_indicator) {
            
            UIActivityIndicatorView *indicator =
            [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _indicator = indicator;

            CGFloat vW = self.view.width;
            CGFloat vH = self.view.height;
            indicator.center = CGPointMake(vW/2., vH/2.-20);
            [indicator startAnimating];
            [self.view addSubview:indicator];
        }
        [self.view bringSubviewToFront:_indicator];
    }
    else {
        
        if (_indicator) {
            [_indicator stopAnimating];
            [_indicator setHidden:YES];
            [_indicator removeFromSuperview];
            _indicator = nil;
        }
    }
}


/**
 *  系统专题栏风格
 *
 *  @return 白色内容风格
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



#pragma mark- UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnim;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnim;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.sliderInteractive.interacting ? self.sliderInteractive:nil;
}


#pragma mark PullToRefresh

-(void)loadRefreshPics{
    pullAnimationImages = [NSMutableArray array];
    shakeAnimationImages = [NSMutableArray array];
    
    NSArray *pullAnimationName = @[
                                   @"icon_pull_animation_1",
                                   @"icon_pull_animation_2",
                                   @"icon_pull_animation_3",
                                   @"icon_pull_animation_4",
                                   @"icon_pull_animation_5"
                                   ];
    NSArray *shakeAnimationName = @[
                                    @"icon_shake_animation_1",
                                    @"icon_shake_animation_2",
                                    @"icon_shake_animation_3",
                                    @"icon_shake_animation_4",
                                    @"icon_shake_animation_5",
                                    @"icon_shake_animation_6",
                                    @"icon_shake_animation_7",
                                    @"icon_shake_animation_8"
                                    ];
    for (NSString *str in pullAnimationName) {
        UIImage *image = [UIImage imageNamed:str];
        [pullAnimationImages addObject:image];
    }
    
    for (NSString *str in shakeAnimationName) {
        UIImage *image = [UIImage imageNamed:str];
        [shakeAnimationImages addObject:image];
    }
    [self shouldAddPullToRefresh:YES];
}


- (void)shouldAddPullToRefresh:(BOOL)isAdd
{
    if (isAdd) {
        MJRefreshGifHeader *header =
        [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadInfomation)];
        // 设置普通状态的动画图片
        [header setImages:@[ [UIImage imageNamed:@"icon_transform_animation"] ] forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:pullAnimationImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:shakeAnimationImages forState:MJRefreshStateRefreshing];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        // 设置header
        self.tableView.mj_header = header;
    } else {
        self.tableView.mj_header = nil;
    }
}

//结束刷新
-(void)endRefresh{
    //[self.tableView.mj_header endRefreshing];
    //[self.mainTableView.mj_footer endRefreshing];
}
//刷新业务具体方法
-(void)loadInfomation{}
@end
