//
//  PBCollectionViewCell.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/10.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PBCollectionViewCell.h"
#import <YYKit.h>

@interface PBCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pbImageView;

@end

@implementation PBCollectionViewCell

- (void)setPicUrlStr:(NSString *)urlStr{
    if (urlStr.length && urlStr) {
        _picUrlStr = urlStr;
        [self.pbImageView setImageWithURL:[NSURL URLWithString:urlStr] placeholder:nil];
    }
    
}

@end
