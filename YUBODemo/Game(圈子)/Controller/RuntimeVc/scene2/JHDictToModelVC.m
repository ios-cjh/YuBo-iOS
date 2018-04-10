//
//  JHDictToModelVC.m
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHDictToModelVC.h"
#import "JHModel.h"
#import "NSObject+hook.h"

@interface JHDictToModelVC ()

@end

@implementation JHDictToModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = @{@"name":@"我爱NBA",
                          @"sex":@"男",
                          @"age":@25
                          };
    JHModel *model = [JHModel modelWithDict:dic];
    NSLog(@"name:%@  sex:%@  ",model.name,model.sex);
}




@end
