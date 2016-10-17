//
//  MeViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "MeViewController.h"
#import "Users.h"
#import "UserManager.h"
#import "LoginViewController.h"
#import "LJCMeHeadView.h"
#import "WeiboCell.h"
#import "Messages.h"
#import "Userinfo.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellId;
    NSArray *messagesArr;
    Users *user;
    CGFloat initialHeight;
}
@property(nonatomic,weak)UITableView *mainTableView;
//@property(nonatomic,weak)LJCMeHeadView *headView;
@property(weak,nonatomic)UIButton *searchBtn;
@property(weak,nonatomic)UIButton *settingBtn;
@end


@implementation MeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cell";
    initialHeight = 200.f;
    //self.topView.backgroundColor = CLEAR_COLOR;
    //加载数据
    [self loadInfomation];
    //user = [Users new];
    //user.usersNikename = @"乐一游劉";
    //user.userinfos
    if (!user) {
        user = [[UserManager sharedInstance] loginedUser];
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.controllerState = LoginControlerState;
        [self presentController:loginVC];
    }else{
        self.title = user.usersNikename;
        [self.topView addSubview:self.searchBtn];
        [self.topView addSubview:self.settingBtn];
        [self.view addSubview:self.mainTableView];
        [self subviewLayouts];
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

-(void)subviewLayouts{
    @weakify(self)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        UIEdgeInsets inset = UIEdgeInsetsMake(40,0,50,0);
        make.edges.equalTo(self.view).insets(inset);
        //make.edges.equalTo(self.view);
    }];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topView.mas_top).offset(5);
        make.right.equalTo(self.topView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topView.mas_top).offset(10);
        make.right.equalTo(self.settingBtn.mas_left).offset(-10);
        //make.left.equalTo(self.sexAddrLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *mainTableView = [UITableView new];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.rowHeight = UITableViewAutomaticDimension;
        mainTableView.estimatedRowHeight = 120.f;
        //mainTableView.backgroundColor = CLEAR_COLOR;
        mainTableView.contentInset = UIEdgeInsetsMake(initialHeight, 0, 0, 0);
        [mainTableView registerClass:[WeiboCell class] forCellReuseIdentifier:cellId];
        LJCMeHeadView *headView = [[LJCMeHeadView alloc] initWithTableView:mainTableView initialHeight:initialHeight];
        [headView setLocalUser:user];
        [mainTableView addSubview:headView];
        
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainTableView.mas_bottom).offset(-initialHeight);
            make.left.equalTo(mainTableView.mas_left);
            make.right.equalTo(mainTableView.mas_right);
            make.bottom.equalTo(mainTableView.mas_top);
        }];
        
        return _mainTableView = mainTableView;
    }
    return _mainTableView;
}
/*
-(LJCMeHeadView *)headView{
    if (!_headView) {
        LJCMeHeadView *headView = [[LJCMeHeadView alloc] initWithTableView:_mainTableView initialHeight:initialHeight];
        [headView setLocalUser:user];
        return _headView = headView;
    }
    return _headView;
}
*/
-(UIButton *)searchBtn{
    if (!_searchBtn) {
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
        
        return _searchBtn = searchBtn;
    }
    return _searchBtn;
}

-(UIButton *)settingBtn{
    if (!_settingBtn) {
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingBtn setImage:[UIImage imageNamed:@"button_icon_setting"] forState:UIControlStateNormal];
        return _settingBtn = settingBtn;
    }
    return _settingBtn;
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

#pragma mark UITableViewDelegate
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


#pragma mark UITableViewDataSource

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 120.0f;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return self.headView;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messagesArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Messages *message = messagesArr[indexPath.row];
    
    if ([message.messages_type isEqualToString:@"WEIBO_TEXT_PIC"]) {
        cell.weiboType = WEIBO_TEXT_PIC;
    }
    
    [cell bindCellDataWithMessage:message];
    return cell;
}

@end
