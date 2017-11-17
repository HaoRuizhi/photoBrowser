//
//  PBProgressView.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PBProgressView.h"

@implementation PBProgressView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    // 获取参数
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width * 0.5 - 3;
    CGFloat startAngel = -M_PI_2;
    CGFloat endAngel = startAngel + self.progress * 2 *M_PI;
    // 创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngel endAngle:endAngel clockwise:YES];
    // 绘制一条中心的线
    [path addLineToPoint:center];
    [path closePath];
    
    // 设置绘制颜色
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] setFill];
    
    // 开始绘制
    [path fill];
    
}


@end
