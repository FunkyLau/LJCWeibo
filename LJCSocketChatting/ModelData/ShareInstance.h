//
//  ShareInstance.h
//  weibo
//
//  Created by 嘉晨刘 on 6/6/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareInstance : NSObject
@property(nonatomic,strong)NSString *usersID;
@property(nonatomic,copy)NSMutableArray *weibos;
@property(nonatomic,copy)NSMutableArray *nickNames;
@property(nonatomic,copy)NSMutableArray *weiboUsersIds;
@property(nonatomic,strong)NSString * detailLabel;
@property(nonatomic,strong)NSString * detailText;
+(instancetype)sharedInstance;

@end
