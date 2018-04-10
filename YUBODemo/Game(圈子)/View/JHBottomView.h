//
//  JHBottomView.h
//  YUBODemo
//
//  Created by cjh on 2018/2/8.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBottomView : UIView


@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, assign) int columnCount;

/**
  关闭视图
 */

-(void)closeMyVcView:(void(^)(void))complete;
/**
 显示视图
 */
-(void)show;

@end
