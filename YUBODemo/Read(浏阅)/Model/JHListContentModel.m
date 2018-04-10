//
//  JHListContentModel.m
//  YUBODemo
//
//  Created by cjh on 2018/2/5.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHListContentModel.h"

@implementation JHListContentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"aDescription":@"description", @"aID":@"id"};
}


@end
