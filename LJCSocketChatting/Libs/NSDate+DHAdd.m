//
//  NSDate+DHAdd.m
//  CreditDemand
//
//  Created by XuXg on 16/1/20.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "NSDate+DHAdd.h"

@implementation NSDate (DHAdd)


-(NSString *)customTimeFormat {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self];

    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
    else{
        result = [self stringWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    return  result;
}

@end
