//
//  ShareInstance.m
//  weibo
//
//  Created by 嘉晨刘 on 6/6/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import "ShareInstance.h"

@implementation ShareInstance

+(instancetype)sharedInstance {
    static ShareInstance *_instance = nil;
    static dispatch_once_t  token;
    dispatch_once(&token, ^{
        if (_instance == nil ) {
            _instance = [[ShareInstance alloc] init];
        }
    });
    return _instance;
}
-(NSString *)usersId{
     NSString *usersId = [[NSString alloc]init];
    if (_usersID!=nil) {
       
        usersId = _usersID;
    }
    return usersId;
}
-(NSMutableArray *)weibos{
    NSMutableArray * weibos = [NSMutableArray array];
    if (_weibos != nil) {
        weibos = _weibos;
    }
    return weibos;
}
-(NSMutableArray *)nickNames{
    NSMutableArray * nickNames = [NSMutableArray array];
    if (_nickNames != nil) {
        nickNames = _nickNames;
    }
    return nickNames;
}
-(NSMutableArray *)weiboUsersIds{
    NSMutableArray * weiboUsersIds = [NSMutableArray array];
    if (_weiboUsersIds != nil) {
        weiboUsersIds = _weiboUsersIds;
    }
    return weiboUsersIds;
}
-(NSString *)detailLabel{
    NSString *detailLabel = [[NSString alloc]init];
    if (_detailLabel != nil) {
        detailLabel = _detailLabel;
    }
    return detailLabel;
}

-(NSString *)detailText{
    NSString *detailText = [[NSString alloc]init];
    if (_detailText != nil) {
        detailText = _detailText;
    }
    return detailText;
}
@end
