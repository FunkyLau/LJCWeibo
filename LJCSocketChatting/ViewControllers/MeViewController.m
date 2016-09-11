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


@implementation MeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    Users *user = [[UserManager sharedInstance] loginedUser];
    
    if (!user) {
        [self presentController:[LoginViewController new]];
    }
}


@end
