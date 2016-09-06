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
}
@property (nonatomic,weak)UITableView *mainTableView;

@end

@implementation HomeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cell";
    
    UIImage *btnImage = [YYImage imageNamed:@"mask_timeline_top_icon_2"];
    btnImage = [UIImage imageWithSize:CGSizeMake(34, 34) drawBlock:^(CGContextRef context) {
        [btnImage drawInRect:CGRectMake(0, 0, 34, 34) withContentMode:UIViewContentModeScaleAspectFill clipsToBounds:YES];
    }];
    
    [self.topRightButton setImage:btnImage forState:UIControlStateNormal];
    Users *user = [[UserManager sharedInstance] loginedUser];
    if (!user) {
        user = [[Users alloc] init];
    }
    user.usersNikename = @"乐一游劉";
    [self setTitle:user.usersNikename];
    //button_icon_group   timeline_setting_lineheight_decrement_icon
    //[self.topRightButton setImage:[UIImage imageNamed:@"mask_timeline_top_icon_2"] forState:UIControlStateNormal];
    [self.navigationController setNavigationBarHidden:NO];
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView registerClass:[WeiboCell class] forCellReuseIdentifier:cellId];
    
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
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *tableView = [UITableView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 120.f;
        return _mainTableView = tableView;
    }
    return _mainTableView;
}

#pragma mark UITableViewDelegate

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (indexPath.row == 1) {
        cell.weiboType = WEIBO_TEXT_PIC;
    }
    /*
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.message = _message;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     */
    //[cell layoutIfNeeded];
    return cell;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
    Messages * _message = [Messages new];
    _message.users = [Users new];
    _message.users.usersNikename = @"大话西游";
    _message.messages_time = @"2小时前";
    _message.messages_info = @"我想从成都挖个人才来我司工作，待遇性格什么都谈好了，他现在只有最后一个问题，就是小孩在上海怎么上学的问题，能解决这个就来。我这方面没经验，咨询一下各位，目前夫妻双方都不是上海人的情况下，怎么解决他小孩上学问题呢？是怎么个流程呢？";
    _message.messages_type = @"";
    
    
    
    [cell bindCellDataWithMessage:_message];
    
    //[cell layoutIfNeeded];
}
@end
