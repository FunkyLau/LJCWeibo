//
//  LJCCustomField.m
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 16/9/9.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#import "LJCCustomField.h"

@interface LJCCustomField ()
@property (nonatomic,weak)UITextField *textField;
@end

@implementation LJCCustomField

-(instancetype)initWithPlaceHolder:(NSString *)placeHolderStr{
    if (self != [super init]) {
        return nil;
    }
    self.textField.placeholder = placeHolderStr;
    [self addSubview:self.textField];
    @weakify(self)
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        //make.edges.equalTo(self).insets
        UIEdgeInsets inset = UIEdgeInsetsMake(0,0,1,0);
        make.edges.equalTo(self).insets(inset);
    }];
    if ([self.textField.placeholder isEqualToString:@"请输入密码"]) {
        self.textField.secureTextEntry = YES;
    }
    UIView *lineView = [UIView new];
    lineView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.textField.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

-(UITextField *)textField{
    if (!_textField) {
        UITextField *textField = [UITextField new];
        textField.borderStyle = UITextBorderStyleNone; //UITextBorderStyleNone
        textField.textColor = BLACK_COLOR;
        textField.font = Font(12);
        return _textField = textField;
    }
    return _textField;
}

@end
