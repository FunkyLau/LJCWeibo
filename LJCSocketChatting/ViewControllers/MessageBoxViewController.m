//
//  MessageBoxViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "MessageBoxViewController.h"
#import "WeiboCell.h"
#import "Comments.h"
#import "Users.h"
#import "Messages.h"

@interface MessageBoxViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellId;
    Comments *comment;
    
}
@property(weak,nonatomic)UITableView *mainTableView;
@property(weak,nonatomic)UISegmentedControl *switcher;
@end

@implementation MessageBoxViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cell";
    comment = [Comments new];
    comment.commentsInfo = @"本文不会花太长篇幅来描述这些 controller 的实现细节，只会重点关注在收发信息的过程，游戏状态和数据是怎么变化的。关于具体实现，请自行阅读 Github 上的源码。我们的插件刚启动的时候处于compact状态。";
    comment.user = [Users new];
    comment.user.usersNikename = @"乐一游劉";
    //comment.message.messages_id = 11;
    self.title = @"消息";
    [self.view addSubview:self.mainTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    @weakify(self)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        UIEdgeInsets inset  = UIEdgeInsetsMake(40, 0, 50, 0);
        make.edges.equalTo(self.view).insets(inset);
    }];
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        
        mainTableView.rowHeight = UITableViewAutomaticDimension;
        mainTableView.estimatedRowHeight = 60;
        //[mainTableView registerClass:[WeiboCell class] forCellReuseIdentifier:cellId];
        //mainTableView.backgroundColor = CLEAR_COLOR;
        return _mainTableView = mainTableView;
    }
    return _mainTableView;
}

-(UISegmentedControl *)switcher{
    if (!_switcher) {
        NSArray *segmentArray = @[
                                  @"收到的评论",
                                  @"发出的评论"
                                  ];
        UISegmentedControl *switcher = [[UISegmentedControl alloc] initWithItems:segmentArray];
        switcher.selectedSegmentIndex = 0;
        switcher.tintColor = [UIColor lightGrayColor];
        [switcher addTarget:self action:@selector(didClickSegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
        return _switcher = switcher;
    }
    return _switcher;
}

- (void)didClickSegmentedControlAction:(UISegmentedControl *)segmentControl
{
    NSInteger idx = segmentControl.selectedSegmentIndex;
    NSLog(@"%d", idx);
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.font = Font(14);
    cell.textLabel.text = comment.user.usersNikename;
    
    cell.detailTextLabel.font = Font(12);
    cell.detailTextLabel.text = comment.commentsInfo;
    cell.detailTextLabel.numberOfLines = 2;
    cell.imageView.image = [YYImage imageNamed:@"mood_himonoonna_icon_no"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    
    [view addSubview:self.switcher];
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets inset = UIEdgeInsetsMake(3, 5, 3, 5);
        make.edges.equalTo(view).insets(inset);
    }];
    return view;
}

@end
