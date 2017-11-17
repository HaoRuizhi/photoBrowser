//
//  PBImageModel.h
//  PhotoBrowerDemo
//
//  Created by haorise on 2017/11/15.
//  Copyright © 2017年 haorise. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PBImageModel : NSObject

@property (nonatomic, copy) NSString *sPicUrl;
@property (nonatomic, copy) NSString *bPicUrl;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue;

@end
