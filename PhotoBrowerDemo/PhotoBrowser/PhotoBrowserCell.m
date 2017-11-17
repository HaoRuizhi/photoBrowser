//
//  PhotoBrowserCell.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PhotoBrowserCell.h"
#import "PBProgressView.h"
#import <YYKit.h>

@interface PhotoBrowserCell ()
@property (nonatomic, strong) PBProgressView *progressView;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@end

@implementation PhotoBrowserCell

- (PhotoBrowserScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[PhotoBrowserScrollView alloc] init];
        
    }
    return _scrollView;
}


- (PBProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[PBProgressView alloc] init];
    }
    return _progressView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // 1.添加子控件
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.progressView];
    // 2.设置子控件frame
    self.scrollView.frame = CGRectMake(0, 0, self.contentView.frame.size.width-20, self.contentView.frame.size.height);
    self.progressView.bounds = CGRectMake(0, 0, 50, 50);
    self.progressView.center = CGPointMake(self.scrollView.frame.size.width * 0.5, self.scrollView.frame.size.height * 0.5);
    
    self.progressView.hidden = YES;
    
}

- (void)setImageModel:(PBImageModel *)imageModel{
    _imageModel = imageModel;
    [self setContentWithModel:_imageModel];
}

// MARK:- 设置cell的内容
- (void)setContentWithModel:(PBImageModel *)imageModel{
    // 1.nil值校验
    if (!imageModel) {
        return;
    }
    // 2.计算imageView的frame
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = width/imageModel.width * imageModel.height;
    float y = 0;
    if (height < [UIScreen mainScreen].bounds.size.height) {
        y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
    }
    self.scrollView.imageView.frame = CGRectMake(0, y, width, height);
    
    UIImage *smallImage = [[YYWebImageManager sharedManager].cache getImageForKey:imageModel.sPicUrl];
    // 3.设置imagView的图片
    self.progressView.hidden = NO;
    typeof(self) weakSelf = self;
    [self.scrollView.imageView setImageWithURL:[NSURL URLWithString:imageModel.bPicUrl] placeholder:smallImage options:YYWebImageOptionShowNetworkActivity progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            CGFloat receive = receivedSize;
            CGFloat total = expectedSize;
            weakSelf.progressView.progress =  receive / total;
    } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        return image;
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        weakSelf.progressView.hidden = YES;
    }];
        
    // 4.设置ScrollView的contentsize
    self.scrollView.contentSize = CGSizeMake(0, height);
}

@end
