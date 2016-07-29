//
//  PhoneSurfTransitionDelegateObj.h
//  SurfNewsHD
//
//  Created by XuXg on 14-11-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    TransitionStylePush = 1,
    TransitionStylePresent,
    TransitionStyleNone,
}TransitionStyle;




// controller 切换动画类型
@interface PresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface DismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@class SuperViewController;
@interface SliderRightInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;


-(instancetype)initWithController:(SuperViewController*)vc;

-(void)addNoGestureRects:(CGRect)objects;
@end
