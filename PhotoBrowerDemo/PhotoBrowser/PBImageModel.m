//
//  PBImageModel.m
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import "PBImageModel.h"

@implementation PBImageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue {
    if((self = [super init])) {
        [self setValuesForKeysWithDictionary:dictionaryValue];
    }
    return self;
}

@end
