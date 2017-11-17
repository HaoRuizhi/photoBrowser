# photoBrowser
简单实用的轻量级OC图片浏览器，后续会推出swift版本

![image](https://github.com/HaoRuizhi/photoBrowser/raw/master/Gif/test.gif)

### 使用
该图片浏览器的使用十分简单。
##### 简要说明：
1.初始化DFPlayer，设置数据源
```
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
```
2.遵守代理
```
- (CGRect)startRect:(NSIndexPath *)indexPath
- (CGRect)endRect:(NSIndexPath *)indexPath
- (UIImageView *)imageView:(NSIndexPath *)indexPath
```

# THANKS!
