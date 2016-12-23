//
//  SettingsViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/10/31.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *cellId;
    NSArray *titlesArr;
}
@property (nonatomic,weak)UITableView *mainTableView;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    cellId = @"cell";
    titlesArr = @[@"账号管理",@"清除缓存",@"关于Weico",@"登出",@"感谢使用"];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insect = UIEdgeInsetsMake(self.topBarHeight,0,0,0);
        make.edges.equalTo(self.view).insets(insect);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.rowHeight = 40;
        mainTableView.tableFooterView = [UIView new];
        //mainTableView.rowHeight = UITableViewAutomaticDimension;
        //mainTableView.estimatedRowHeight = 120.f;
        [mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        //mainTableView.backgroundColor = CLEAR_COLOR;
        [self.view addSubview:mainTableView];
        self.mainTableView = mainTableView;
    }
    return _mainTableView;
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titlesArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = titlesArr[indexPath.section];
    cell.textLabel.font = Font(14);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 20;
}

@end
