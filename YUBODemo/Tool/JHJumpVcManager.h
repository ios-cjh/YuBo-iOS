//
//  JHJumpVcManager.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHJumpVcManager : NSObject
+(instancetype) shareInstance;
@property (nonatomic, strong) UINavigationController *navigationVc;
@end
