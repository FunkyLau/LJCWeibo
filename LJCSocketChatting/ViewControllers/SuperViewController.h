//
//  SuperViewController.h
//  DHTalentReward
//
//  Created by shengzhong on 15/5/27.
//  Copyright (c) 2015年 szwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneSurfViewControllerTransition.h"

typedef enum {
    DHCtrlState_None = 0,                       // 默认没有顶部工具栏
    DHCtrlState_TopBar =        1 << 0,         // 顶部栏(注:需要顶部工具，必须包含此值)
    DHCtrlState_TopBar_Title =  1 << 1,         // 顶部栏标题(居中显示)
    DHCtrlState_TopBar_LBtn_GoBack = 1 << 2,    // 顶部栏左按钮——返回按钮
    DHCtrlState_TopBar_LBtn_Menu = 1 << 3,      // 顶部栏左按钮——菜单按钮
    DHCtrlState_TopBar_RBtn =   1 << 4,         // 顶部栏右边按钮
    //DHCtrlState_TopBar_RBtn_Menu = 1 << 5,   // 顶部栏右边消息类型按钮
    DHCtrlState_GestureGoBack = 1 << 5,         // 手势返回
    DHCtrlState_SearchBar = 1 <<6,              // 顶部栏搜索条
 
    // 显示logo
    ControllerStateShowLogo = (DHCtrlState_TopBar |
                               DHCtrlState_TopBar_Title |
                               DHCtrlState_TopBar_RBtn),
    
    // 显示左边按钮
    ControllerStateOnlyLeftButton = (DHCtrlState_TopBar |
                                     DHCtrlState_TopBar_LBtn_GoBack |
                                     DHCtrlState_TopBar_Title |
                                     DHCtrlState_GestureGoBack),
    
    // 显示左右按钮
    ControllerStateWithBothButton = (DHCtrlState_TopBar |
                                     DHCtrlState_TopBar_Title |
                                     DHCtrlState_TopBar_LBtn_GoBack |
                                     DHCtrlState_TopBar_RBtn),
    
    // 显示右边功能按钮，中间是搜索栏
    ControllerStateWithRightButtonAndSearchBar = (DHCtrlState_TopBar|
                                                 //DHCtrlState_TopBar_LBtn_Menu|
                                                 DHCtrlState_TopBar_RBtn|
                                                 DHCtrlState_SearchBar),
    
    // 显示左右功能按钮，中间是title
    ControllerStateWithBothMenuButton = (DHCtrlState_TopBar |
                                     DHCtrlState_TopBar_Title |
                                     DHCtrlState_TopBar_LBtn_Menu |
                                     DHCtrlState_TopBar_RBtn),
    //只有左右功能按钮（登录）
    LoginControlerState = (DHCtrlState_TopBar |
                           DHCtrlState_TopBar_LBtn_GoBack |
                           DHCtrlState_TopBar_RBtn)
    
    
} ControllerState;

static NSInteger const topToolBarHeight = 68;

@interface SuperViewController : UIViewController
{
    //点击事件专有
    UIImageView *_lastScreenShotView;
    UIView *_backgroundView;
    UIView *_blackMask;
    CGPoint _startTouch;
//    BOOL _isMoving;
    float _startBackViewX;

}

@property (nonatomic, readonly, weak) UIView        *topView;       //顶部工具栏
@property (nonatomic, readonly) UIImageView         *topImageView;
@property (nonatomic, readonly, weak) UIButton      *topLeftButton;
@property (nonatomic, readonly, weak) UIButton      *topRightButton;
@property (nonatomic, readonly) UIButton      *topRealRightButton;
@property (nonatomic, weak)     UIView * searchView;
@property (nonatomic, readonly) CGFloat       topBarHeight;
@property (nonatomic) ControllerState          controllerState;
@property (nonatomic, readonly) UIView        *bgView;
@property (nonatomic, readonly) CGFloat       width;      /**< controller View 宽度  */
@property (nonatomic, readonly) CGFloat       height;     /**< controller View 高度  */
@property (nonatomic, readonly) CGFloat       centerX;
@property (nonatomic, readonly) CGFloat       centerY;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, assign) BOOL shouldInitPullToRefresh;




- (void)presentController:(UIViewController *)viewController;
- (void)dismissControllerAnimated;
- (void)showRightButton:(UIButton *)rightButton;


- (void)showErrorView:(NSString*)errorTitle
         refreshEvent:(void (^)())block; // 默认显示“数据加载失败”
- (void)hidderErrorView;

// 工具函数
-(void)showLoadingUI:(BOOL)show;
-(void)setTitileFont:(UIFont*)font;

//下拉刷新(子类重写)
-(void)loadRefreshPics;
- (void)shouldAddPullToRefresh:(BOOL)isAdd;
-(void)loadInfomation;
-(void)endRefresh;
@end
