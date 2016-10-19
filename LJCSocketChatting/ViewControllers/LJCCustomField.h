//
//  LJCCustomField.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/9.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SetTextLength)(int);
@interface LJCCustomField : UIView

@property(nonatomic,strong)SetTextLength setTextLengthBlock;
-(instancetype)initWithPlaceHolder:(NSString *)placeHolderStr;
-(void)setSecurityMode;


@end
