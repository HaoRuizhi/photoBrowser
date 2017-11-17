//
//  PhotoBrowserAnimator.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PhotoBrowserAnimator.h"

@interface PhotoBrowserAnimator()

@property (assign, nonatomic) BOOL isPresented;

@end

@implementation PhotoBrowserAnimator


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresented = NO;
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    _isPresented ? [self animationForPresentedView:transitionContext] : [self animationForDismissView:transitionContext];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animationForPresentedView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (!self.indexPath || !self.presentedDelegate) {
        return;
    }
    
    // 1.取出弹出的View
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 2.将prensentedView添加到containerView中
    [transitionContext.containerView addSubview:presentedView];
    // 3.获取执行动画的imageView
    CGRect startFrame = [self.presentedDelegate startRect:self.indexPath];
    UIImageView *cellImageView = [self.presentedDelegate imageView:self.indexPath];
    [transitionContext.containerView addSubview:cellImageView];
    cellImageView.frame = startFrame;
    // 4.开始动画
    presentedView.alpha = 0;
    transitionContext.containerView.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        cellImageView.frame = [self.presentedDelegate endRect:self.indexPath];
    } completion:^(BOOL finished) {
        [cellImageView removeFromSuperview];
        presentedView.alpha = 1;
        transitionContext.containerView.backgroundColor = [UIColor clearColor];
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)animationForDismissView:(nonnull id<UIViewControllerContextTransitioning>)transitionContext{
    // 1.取出消失的View
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    
    // 2.获取执行动画的ImageView
    UIImageView *imageView = self.dismissedDelegate.imageViewOfDimissView;
    [transitionContext.containerView addSubview:imageView];
    NSIndexPath *indexPath = self.dismissedDelegate.indexPathOfDismissView;
    
    
    // 3.执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [self.presentedDelegate startRect:indexPath];
    } completion:^(BOOL finished) {
        dismissView.alpha = 0;
        [dismissView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
