//
//  JHDataBase.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/7.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHPrettyPicDataModel.h"

@interface JHDataBase : NSObject

+(instancetype) shareDataBase;

/**
 存储数据

 @param prettyPicDataModel 美图的数据模型
 */
-(void)addPrettyDatas:(JHPrettyPicDataModel *)prettyPicDataModel;

/**
 获取数据
 */
- (NSMutableArray *)getAllPrettyPicDataModel;

@end
