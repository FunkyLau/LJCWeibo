//
//  PersonalProfileViewController.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/12/13.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "SuperViewController.h"
#import "RegistViewController.h"

@class Users;


@interface PersonalProfileViewController : SuperViewController

@property(nonatomic,strong)Users *user;
@property(nonatomic,strong)id<JumpToLoginDelegate> jumpDelegate;


@end
