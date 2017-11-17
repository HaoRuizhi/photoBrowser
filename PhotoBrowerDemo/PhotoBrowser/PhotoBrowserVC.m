//
//  PhotoBrowserVC.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/10.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PhotoBrowserVC.h"
#import "PhotoBrowserCell.h"

static NSString *kPhotoBrowserCellId = @"PhotoBrowserCellId";
@implementation PhotoBrowserVCLayout

- (void)prepareLayout{
    [super prepareLayout];
    // 1.设置itemSize
    self.itemSize = self.collectionView.frame.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UILayoutConstraintAxisVertical;
    
    // 2.设置collectionView的属性
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end

@interface PhotoBrowserVC ()<UICollectionViewDelegate, UICollectionViewDataSource, PhotoBrowserScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *photoCollectionView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation PhotoBrowserVC

- (UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[PhotoBrowserVCLayout new]];
    }
    return _photoCollectionView;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height - 20, 80, 20)];
        [_closeBtn setTitle:@"保 存" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIPageControl *)pageControl{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 30);
        //设置背景颜色
        _pageControl.backgroundColor = [UIColor clearColor];
        //设置 小圆圈的颜色
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#333333"];
        
        //设置当前页的小圆圈颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (void)loadView{
    [super loadView];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width + 20, self.view.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI{
    // 1.添加子控件
    [self.view addSubview:self.photoCollectionView];
    [self.view addSubview:self.pageControl];
//    [self.view addSubview:self.closeBtn];
    
    // 2.设置frame
    self.photoCollectionView.frame = self.view.bounds;
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    [self.photoCollectionView registerClass:[PhotoBrowserCell class] forCellWithReuseIdentifier:kPhotoBrowserCellId];
    
    [self.photoCollectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    //设置小圆圈的个数
    _pageControl.numberOfPages = self.imageModels.count;
    //获取/更改当前页
    _pageControl.currentPage = self.currentIndexPath.row;
    
}

- (void)saveBtnClick{
    PhotoBrowserCell *cell = (PhotoBrowserCell *)[self.photoCollectionView visibleCells].firstObject;
    if (!cell.scrollView.imageView.image) {
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(cell.scrollView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败");
    }
}

#pragma mark  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoBrowserCellId forIndexPath:indexPath];
    cell.scrollView.dismissDelegate = self;
    cell.imageModel = self.imageModels[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //page的计算方法为scrollView的偏移量除以屏幕的宽度即为第几页。
    int page = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    self.pageControl.currentPage = page;
}


#pragma mark  AnimatorDismissedDelegate
- (NSIndexPath *)indexPathOfDismissView{
    // 获取当前正在显示的indexPath
    UICollectionViewCell *cell = [self.photoCollectionView visibleCells].firstObject;
    return [self.photoCollectionView indexPathForCell:cell];
}

- (UIImageView *)imageViewOfDimissView{
    // 返回当前显示cell中的imageView
    PhotoBrowserCell *cell = (PhotoBrowserCell *)[self.photoCollectionView visibleCells].firstObject;
    return cell.scrollView.imageView;
}

#pragma mark PhotoBrowserCellDelegate

- (void)PBCellimageViewClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
