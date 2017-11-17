//
//  PhotoBrowserScrollView.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/17.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PhotoBrowserScrollView.h"

@interface PhotoBrowserScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) YYAnimatedImageView *imageView;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@end

@implementation PhotoBrowserScrollView

- (YYAnimatedImageView *)imageView{
    if (!_imageView) {
        _imageView = [[YYAnimatedImageView alloc] init];
    }
    return _imageView;
}

- (instancetype)init{
    if(self = [super init]){
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 2.5;
        self.delegate = self;
        // 添加ImageView tap事件
        [self.imageView addGestureRecognizer:self.singleTap];
        [self.imageView addGestureRecognizer:self.doubleTap];
        [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
        self.imageView.userInteractionEnabled = YES;
        
        [self addSubview:self.imageView];
    }
    return self;
}

- (UITapGestureRecognizer *)singleTap{
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)];
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)doubleTap{
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapAction:)];
        _doubleTap.numberOfTapsRequired = 2;
    }
    return _doubleTap;
}

// MARK:- 事件监听
- (void)imageViewClick{
    if (self.dismissDelegate && [self.dismissDelegate respondsToSelector:@selector(PBCellimageViewClick)]) {
        [self.dismissDelegate PBCellimageViewClick];
    }
}

- (void)handleDoubleTapAction:(UITapGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint location = [sender locationInView:self];
    [self handleZoomForLocation:location];
    //    PBImageScrollView *imageScrollView = self.currentScrollViewController.imageScrollView;
    //    [imageScrollView _handleZoomForLocation:location];
}

- (void)handleZoomForLocation:(CGPoint)location {
    CGPoint touchPoint = [self.superview convertPoint:location toView:self.imageView];
    if (self.zoomScale > 1) {
        [self setZoomScale:1 animated:YES];
    } else if (self.maximumZoomScale > 1) {
        CGFloat newZoomScale = self.maximumZoomScale;
        CGFloat horizontalSize = CGRectGetWidth(self.bounds) / newZoomScale;
        CGFloat verticalSize = CGRectGetHeight(self.bounds) / newZoomScale;
        CGRect zoomRect = CGRectMake(touchPoint.x - horizontalSize / 2.0f, touchPoint.y - verticalSize / 2.0f, horizontalSize, verticalSize);
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (void)recenterImage {
    CGFloat contentWidth = self.contentSize.width;
    CGFloat horizontalDiff = CGRectGetWidth(self.bounds) - contentWidth;
    CGFloat horizontalAddition = horizontalDiff > 0.f ? horizontalDiff : 0.f;
    
    CGFloat contentHeight = self.contentSize.height;
    CGFloat verticalDiff = CGRectGetHeight(self.bounds) - contentHeight;
    CGFloat verticalAdditon = verticalDiff > 0 ? verticalDiff : 0.f;
    
    self.imageView.center = CGPointMake((contentWidth + horizontalAddition) / 2.0f, (contentHeight + verticalAdditon) / 2.0f);
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self recenterImage];
}


@end
