//
//  HomeViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboCell.h"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellId;
}
@property (nonatomic,weak)UITableView *mainTableView;

@end

@implementation HomeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    cellId = @"cell";
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
        
        UIEdgeInsets inset = UIEdgeInsetsMake(0,0,50,0);
        make.edges.equalTo(self.view).insets(inset);
        //make.edges.equalTo(self.view);
    }];
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *tableView = [UITableView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        return _mainTableView = tableView;
    }
    return _mainTableView;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.weiboType = WEIBO_ONLY_TEXT;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

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
