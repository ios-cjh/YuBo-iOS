//
//  JHMessageModel.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMessageModel : NSObject
// 头像、名字、和描述文字我给固定了,所以没有弄属性处理
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *content;

// 图片将要展示的frame
@property (nonatomic, assign) CGRect contentImageFrame;

@property (nonatomic, assign, readonly) CGFloat cellHeight;// 只能读取， 不能修改

+ (instancetype)messageWithDic:(NSDictionary *)dic; // 字典转模型
@end
