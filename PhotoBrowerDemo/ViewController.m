//
//  ViewController.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/10.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "ViewController.h"
#import "PBCollectionViewCell.h"
#import "PhotoBrowserVC.h"
#import "PBImageModel.h"
#import "PhotoBrowserAnimator.h"
#import <YYKit.h>
#import <NSObject+YYModel.h>

#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

static NSString *kPBCollectionViewCellId = @"PBCollectionViewCellId";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, AnimatorPresentedDelegate>

@property (strong, nonatomic) NSMutableArray<PBImageModel *> *picModels;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (strong, nonatomic) PhotoBrowserAnimator *modalAnimator;

@end

@implementation ViewController

- (PhotoBrowserAnimator *)modalAnimator{
    if (!_modalAnimator) {
        _modalAnimator = [[PhotoBrowserAnimator alloc] init];
    }
    return _modalAnimator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    [self setupData];

}

- (void)setupUI{
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.imageCollectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(UI_SCREEN_WIDTH * 0.3, UI_SCREEN_WIDTH * 0.3);
    
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
}

- (void)setupData{
    
    NSArray *picInfoArray = @[
  @{@"sPicUrl":@"https://wx3.sinaimg.cn/orj360/a69337f3ly1fkt61goaw0g2078078npg.gif",@"bPicUrl":@"https://wx3.sinaimg.cn/large/a69337f3ly1fkt61goaw0g2078078npg.gif",@"width": @"260",@"height": @"260"},
  @{@"sPicUrl":@"https://wx1.sinaimg.cn/orj360/bf4ee2c0gy1fkmgply1jzj20m80gbjve.jpg",@"bPicUrl":@"https://wx1.sinaimg.cn/large/bf4ee2c0gy1fkmgply1jzj20m80gbjve.jpg",@"width": @"367",@"height": @"270"},
  @{@"sPicUrl":@"https://wx2.sinaimg.cn/orj360/bf4ee2c0gy1fkmgpmspk0j20hs0c2770.jpg",@"bPicUrl":@"https://wx2.sinaimg.cn/large/bf4ee2c0gy1fkmgpmspk0j20hs0c2770.jpg",@"width": @"398",@"height": @"270"},
  @{@"sPicUrl":@"https://wx2.sinaimg.cn/orj360/bf4ee2c0gy1fkmgpn5gvvj20g20bgmz8.jpg",@"bPicUrl":@"https://wx2.sinaimg.cn/large/bf4ee2c0gy1fkmgpn5gvvj20g20bgmz8.jpg",@"width": @"378",@"height": @"270"},
  @{@"sPicUrl":@"https://wx1.sinaimg.cn/orj360/6961aadegy1fkuhb2qqocj20t60xc13m.jpg",@"bPicUrl":@"https://wx1.sinaimg.cn/large/6961aadegy1fkuhb2qqocj20t60xc13m.jpg",@"width": @"360",@"height": @"411"},
  @{@"sPicUrl":@"https://wx2.sinaimg.cn/orj360/6961aadegy1fkuhb0cl6rj20s50xck1k.jpg",@"bPicUrl":@"https://wx2.sinaimg.cn/large/6961aadegy1fkuhb0cl6rj20s50xck1k.jpg",@"width": @"360",@"height": @"426"},
  @{@"sPicUrl":@"https://wx3.sinaimg.cn/orj360/6961aadegy1fkuhb1wdb7j20qy0xcajx.jpg",@"bPicUrl":@"https://wx3.sinaimg.cn/large/6961aadegy1fkuhb1wdb7j20qy0xcajx.jpg",@"width": @"360",@"height": @"445"},
  @{@"sPicUrl":@"https://wx1.sinaimg.cn/orj360/6961aadegy1fkuhb382fej20pb0xcqch.jpg",@"bPicUrl":@"https://wx1.sinaimg.cn/large/6961aadegy1fkuhb382fej20pb0xcqch.jpg",@"width": @"360",@"height": @"474"},
  @{@"sPicUrl":@"https://wx2.sinaimg.cn/orj360/6961aadegy1fkuhb24hknj20qp0xcn6m.jpg",@"bPicUrl":@"https://wx2.sinaimg.cn/large/6961aadegy1fkuhb24hknj20qp0xcn6m.jpg",@"width": @"360",@"height": @"449"}];
    self.picModels = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in picInfoArray) {
        PBImageModel *model = [[PBImageModel alloc] initWithDictionary:dic];
        [self.picModels addObject:model];
    }
    
    [self.imageCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picModels.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PBCollectionCellID" forIndexPath:indexPath];
    PBImageModel *picItem = self.picModels[indexPath.row];
    cell.picUrlStr = picItem.sPicUrl;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1.创建控制器
    PhotoBrowserVC *pbVC = [[PhotoBrowserVC alloc] init];
    
    pbVC.imageModels = self.picModels;
    pbVC.currentIndexPath = indexPath;
    // 2.设置modal样式
    pbVC.modalPresentationStyle = UIModalPresentationCustom;

    // 3.设置转场的代理
    pbVC.transitioningDelegate = self.modalAnimator;

    // 4.设置动画的代理
    self.modalAnimator.presentedDelegate = self;
    self.modalAnimator.indexPath = indexPath;
    self.modalAnimator.dismissedDelegate = pbVC;    
    
    [self presentViewController:pbVC animated:YES completion:nil];
}

#pragma mark - AnimatorPresentedDelegate

- (CGRect)startRect:(NSIndexPath *)indexPath{
    // 1.获取cell
    UICollectionViewCell *cell = [self.imageCollectionView cellForItemAtIndexPath:indexPath];
    
    // 2.获取cell的frame
    CGRect startFrame = [self.imageCollectionView convertRect:cell.frame toCoordinateSpace:[UIApplication sharedApplication].keyWindow];
    
    return startFrame;
}

- (CGRect)endRect:(NSIndexPath *)indexPath{
    // 1.获取该位置的image对象
    PBImageModel *imageModel = self.picModels[indexPath.item];
    
    // 2.计算结束后的frame
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = w / imageModel.width * imageModel.height;
    CGFloat y = 0;
    if (h < [UIScreen mainScreen].bounds.size.height) {
        y = ([UIScreen mainScreen].bounds.size.height - h) * 0.5;
    }
    
    return CGRectMake(0, y, w, h);
}

- (UIImageView *)imageView:(NSIndexPath *)indexPath{
    // 1.创建UIImageView对象
    UIImageView* imageView = [[UIImageView alloc] init];
    
    // 2.获取该位置的image对象
    PBImageModel *imageModel = self.picModels[indexPath.item];
    NSString *picURL = imageModel.sPicUrl;
    
    UIImage *image = [[YYWebImageManager sharedManager].cache getImageForKey:picURL];
    
    // 3.设置imageView的属性
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    
    return imageView;
}

@end
