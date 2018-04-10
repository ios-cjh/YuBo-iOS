//
//  JHAddPropertyToCategoryVC.m
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

/**
 动态给分类添加属性
 */
#import "JHAddPropertyToCategoryVC.h"
#import "UIGestureRecognizer+Block.h"

@interface JHAddPropertyToCategoryVC ()

@end

@implementation JHAddPropertyToCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *viewM = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, 40, 40);
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = YES;
    label.textColor = [UIColor whiteColor];
    label.text = @"点我哈！";
    [label sizeToFit];
    
    
    viewM.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viewM];
    [viewM addSubview:label];
    
    UILabel *textLabel =  [[UILabel alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH -kSCREEN_WIDTH * 3/4) / 2 , 300, kSCREEN_WIDTH * 3/4 , 250)];
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:textLabel];
    
    [viewM addGestureRecognizer:[UITapGestureRecognizer hh_gestureRecognizerWithActionBlock:^(id gestureRecognizer) {
        textLabel.textColor = [UIColor whiteColor];
        textLabel.text = @"动态给分类添加属性\n [viewM addGestureRecognizer:[UITapGestureRecognizer hh_gestureRecognizerWithActionBlock:^(id gestureRecognizer) {\n\n}]];";
    }]];
}



@end
