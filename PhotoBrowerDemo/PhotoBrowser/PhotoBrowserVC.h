//
//  PhotoBrowserVC.h
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/10.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserAnimator.h"

@class PBImageModel;

@interface PhotoBrowserVCLayout : UICollectionViewFlowLayout

@end

@interface PhotoBrowserVC : UIViewController<AnimatorDismissedDelegate>

@property (nonatomic, strong) NSArray<PBImageModel *> *imageModels;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
