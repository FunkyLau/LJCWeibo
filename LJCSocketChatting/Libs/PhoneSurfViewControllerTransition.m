//
//  PhoneSurfTransitionDelegateObj.m
//  SurfNewsHD
//
//  Created by XuXg on 14-11-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PhoneSurfViewControllerTransition.h"




@implementation PresentAnimation


// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for toVC
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, kScreenWidth, 0.f);
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 添加一个蒙版
    UIView* blackMask = [[UIView alloc]initWithFrame:containerView.bounds];
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.alpha = 0.f;
    [fromVC.view addSubview:blackMask];

    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         blackMask.alpha = 0.4f;
                         toVC.view.frame = finalFrame;
                         fromVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(-200, 0);
                     }
                     completion:^(BOOL finished){
            
                         [blackMask removeFromSuperview];
                         fromVC.view.layer.affineTransform = CGAffineTransformIdentity;
                         
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
}

@end





@implementation DismissAnimation


// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, kScreenWidth, 0.f);
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    
    // 添加一个灰色蒙版
    toVC.view.layer.affineTransform = CGAffineTransformMakeTranslation(-200,0);
    UIView* blackMask = [[UIView alloc]initWithFrame:containerView.bounds];
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.alpha = 0.4f;
    [toVC.view addSubview:blackMask];
    
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        blackMask.alpha = 0.f;
        fromVC.view.frame = finalFrame;
        toVC.view.layer.affineTransform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [blackMask removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end


@interface SliderRightInteractiveTransition ()<UIGestureRecognizerDelegate>{
 
    SuperViewController *presentVC_;
    BOOL shouldComplete_;
    NSMutableArray *noGestureRects_;
}

@end
@implementation SliderRightInteractiveTransition

-(instancetype)initWithController:(SuperViewController*)vc{
    self = [super init];
    if (self) {
        presentVC_ = vc;
        [self prepareGestureRecognizerInView:vc.view];
    }
    return self;
}

-(void)addNoGestureRects:(CGRect)noGestureR {
    
    if (!noGestureRects_) {
        noGestureRects_ = [NSMutableArray arrayWithCapacity:3];
    }
    
    
    NSValue* noR = [NSValue valueWithCGRect:noGestureR];
    [noGestureRects_ addObject:noR];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.delegate = self;
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [presentVC_ dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.x / presentVC_.view.width;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            shouldComplete_ = (fraction > 0.4);
            
            DJLog(@"滑动百分比 == %f, 滑动距离 = %f", fraction, translation.y);
            
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!shouldComplete_ || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)recognizer
{
    CGPoint p = [recognizer locationInView: presentVC_.view];
    if (p.x > 20.f && p.y < presentVC_.topBarHeight) {
        return NO;
    }
    
    if (noGestureRects_) {
        for (NSValue *value in noGestureRects_ ) {
            
            CGRect r = [value CGRectValue];
            if (CGRectContainsPoint(r, p)) {
                return NO;
            }
        }
    }
    return YES;
}

@end
