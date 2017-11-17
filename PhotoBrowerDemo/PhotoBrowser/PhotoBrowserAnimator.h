//
//  PhotoBrowserAnimator.h
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AnimatorPresentedDelegate <NSObject>

- (CGRect)startRect:(NSIndexPath *)indexPath;
- (CGRect)endRect:(NSIndexPath *)indexPath;
- (UIImageView *)imageView:(NSIndexPath *)indexPath;

@end

@protocol AnimatorDismissedDelegate <NSObject>

- (NSIndexPath *)indexPathOfDismissView;
- (UIImageView *)imageViewOfDimissView;

@end

@interface PhotoBrowserAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) id<AnimatorPresentedDelegate> presentedDelegate;
@property (weak, nonatomic) id<AnimatorDismissedDelegate> dismissedDelegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
