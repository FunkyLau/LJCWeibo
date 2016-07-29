//
//  DHLongPressButton.m
//  CreditDemand
//
//  Created by XuXg on 16/1/20.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "DHLongPressButton.h"


/**
 *  长按按钮
 */

@interface DHLongPressButton () {
    
    NSDate *_date;
}

@property(nonatomic,strong,readonly)UILongPressGestureRecognizer *longPress;

@end
@implementation DHLongPressButton
@synthesize longPress = _longPress;

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //button长按事件
        _pressDuration = 0.2f;
        self.longPress.minimumPressDuration = _pressDuration;
    }
    return self;
}

-(UILongPressGestureRecognizer*)longPress {
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(longPressButtonGesture:)];
        [self addGestureRecognizer:_longPress];
    }
    
    return _longPress;
}
-(void)setPressDuration:(CFTimeInterval)pressDuration {
    _pressDuration = pressDuration;
    self.longPress.minimumPressDuration = pressDuration; //定义按的时间
}

// 暂时就这样写写，以后在重构下
-(void)longPressButtonGesture:(UILongPressGestureRecognizer*)longPress {

    CGPoint p = [longPress locationInView:self.superview];
    CGRect enlR = [self enlargeFrame];
    if (!CGRectContainsPoint(enlR, p)) {
        return;
    }
    
    
    if ([longPress state] == UIGestureRecognizerStateBegan) {
        [self sendActionsForControlEvents:UIControlEventAllEvents];
        _date = [NSDate date];
        
        WS(weakSelf);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_pressDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) self = weakSelf;
            if (!self) return;
            
            if (self.longPress.state == UIGestureRecognizerStateBegan) {
                [self longPressButtonGesture:self.longPress];
            }
        });
    }
    else if ([longPress state] == UIGestureRecognizerStateChanged) {
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:_date];
        if (interval >= _pressDuration) {
            _date = [NSDate date];
            [self sendActionsForControlEvents:UIControlEventAllEvents];
            WS(weakSelf);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_pressDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) self = weakSelf;
                if (!self) return;
                
                if (self.longPress.state == UIGestureRecognizerStateChanged) {
                    [self longPressButtonGesture:self.longPress];
                }
            });
        }
    }
    
    DJLog (@"state = %ld ",(long)[longPress state]);
}

@end
