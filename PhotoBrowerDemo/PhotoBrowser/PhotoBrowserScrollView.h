//
//  PhotoBrowserScrollView.h
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/17.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYKit.h>

@protocol PhotoBrowserScrollViewDelegate <NSObject>

- (void)PBCellimageViewClick;

@end

@interface PhotoBrowserScrollView : UIScrollView

@property (nonatomic, strong, readonly) YYAnimatedImageView *imageView;

@property (nonatomic, assign) id<PhotoBrowserScrollViewDelegate> dismissDelegate;

@end
