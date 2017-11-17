//
//  PhotoBrowserCell.h
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBImageModel.h"
#import "PhotoBrowserScrollView.h"

@interface PhotoBrowserCell : UICollectionViewCell

@property (nonatomic, strong) PBImageModel *imageModel;
@property (nonatomic, strong) PhotoBrowserScrollView *scrollView;

@end
