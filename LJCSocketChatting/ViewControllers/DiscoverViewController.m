//
//  MarketViewController.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/7/26.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "DiscoverViewController.h"

@implementation DiscoverViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        [self presentController:[UIViewController new]];
    }];
    [self.searchView addGestureRecognizer:tapGesture];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}
@end
