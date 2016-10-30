//
//  HomeViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboCell.h"
#import "Messages.h"
#import "Users.h"
#import "UserManager.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellId;
    NSArray *messagesArr;
    NSMutableArray *pullAnimationImages;
    NSMutableArray *shakeAnimationImages;
}
@property (nonatomic,weak)UITableView *mainTableView;

@end

@implementation HomeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cell";
    //加载顶部按钮
    [self showTopBtn];
    //[self loadRefreshPics];
    Users *user = [[UserManager sharedInstance] loginedUser];
    if (!user) {
        user = [[Users alloc] init];
    }
    user.usersNikename = @"乐一游劉";
    [self setTitle:user.usersNikename];
    //加载假数据
    [self loadInfomation];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView registerClass:[WeiboCell class] forCellReuseIdentifier:cellId];
    //[self.mainTableView layoutIfNeeded];
    //[self.mainTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    @weakify(self)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        UIEdgeInsets inset = UIEdgeInsetsMake(40,0,50,0);
        make.edges.equalTo(self.view).insets(inset);
        //make.edges.equalTo(self.view);
    }];
    //加载完重新刷新tableView
    //[self.mainTableView reloadData];
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *tableView = [UITableView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        //tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 120.f;
        return _mainTableView = tableView;
    }
    return _mainTableView;
}

-(void)showTopBtn{
    UIImage *btnImage = [YYImage imageNamed:@"mask_timeline_top_icon_2"];
    btnImage = [UIImage imageWithSize:CGSizeMake(34, 34) drawBlock:^(CGContextRef context) {
        [btnImage drawInRect:CGRectMake(0, 0, 34, 34) withContentMode:UIViewContentModeScaleAspectFill clipsToBounds:YES];
    }];
    
    [self.topRightButton setImage:btnImage forState:UIControlStateNormal];
    //button_icon_group   timeline_setting_lineheight_decrement_icon
    [self.topLeftButton setImage:[UIImage imageNamed:@"button_icon_group"] forState:UIControlStateNormal];
}

-(void)loadInfomation{
    Messages * message1 = [Messages new];
    message1.users = [Users new];
    message1.users.usersNikename = @"大话西游";
    message1.messages_time = @"2小时前";
    message1.messages_info = @"我想从成都挖个人才来我司工作，待遇性格什么都谈好了，他现在只有最后一个问题，就是小孩在上海怎么上学的问题，能解决这个就来。我这方面没经验，咨询一下各位，目前夫妻双方都不是上海人的情况下，怎么解决他小孩上学问题呢？是怎么个流程呢？";
    message1.messages_type = @"WEIBO_TEXT_PIC";
    
    Messages * message2 = [Messages new];
    message2.users = [Users new];
    message2.users.usersNikename = @"乐一游劉";
    message2.messages_time = @"3小时前";
    message2.messages_info = @"本文不会花太长篇幅来描述这些 controller 的实现细节，只会重点关注在收发信息的过程，游戏状态和数据是怎么变化的。关于具体实现，请自行阅读 Github 上的源码。我们的插件刚启动的时候处于compact状态。这点空间并不够展示游戏的棋盘，在 iPhone 上尤其不够。我们可以简单粗暴地立即切换成expanded状态，但是苹果官方警告不要这么做，毕竟还是应该把控制权交给用户。";
    message2.messages_type = @"WEIBO_ONLY_TEXT";
    
    messagesArr = @[message1,message2];
}

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
}

#pragma mark UITableViewDelegate

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return rowheight;
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messagesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    /*
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.message = _message;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     */
    Messages *message = messagesArr[indexPath.row];
    
    if ([message.messages_type isEqualToString:@"WEIBO_TEXT_PIC"]) {
        cell.weiboType = WEIBO_TEXT_PIC;
    }
    
    [cell bindCellDataWithMessage:message];
    return cell;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(WeiboCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        //[cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        //[cell setLayoutMargins:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
    

    
}
@end
