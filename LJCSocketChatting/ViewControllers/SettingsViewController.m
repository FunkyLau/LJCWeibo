//
//  SettingsViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/10/31.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *mainTableView;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        UITableView *mainTableView = [UITableView new];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.rowHeight = UITableViewAutomaticDimension;
        mainTableView.estimatedRowHeight = 120.f;
        //[mainTableView registerClass:[WeiboCell class] forCellReuseIdentifier:cellId];
        //mainTableView.backgroundColor = CLEAR_COLOR;
        return _mainTableView = mainTableView;
    }
    return _mainTableView;
}

@end
