//
//  JHPrettyPicData.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/12.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>
// JHPrettyPicDataModel
@interface JHPrettyPicDataModel : NSObject
    
/*
 *  id
 */
@property (nonatomic, copy) NSString *_id;
/**
 *  资源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  谁发布的
 */
@property (nonatomic, copy) NSString *who;

/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *publishedAt;
/**
 *  used;
 */
@property (nonatomic, assign) BOOL used;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createdAt;
/**
 *  类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  地址Url
 */
@property (nonatomic, copy) NSString *url;

@end
