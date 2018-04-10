//
//  JHFoldViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/3/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHFoldViewController.h"
#import "JHFoldButton.h"

@interface JHFoldViewController ()<JHFoldButtonDelegate>

@end

@implementation JHFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *arr = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8"];
    self.view.backgroundColor = [UIColor whiteColor];
    JHFoldButton *foldBtn = [[JHFoldButton alloc] initWithFrame:CGRectMake(100, 150, 100, 30) dataArray:arr];
    foldBtn.backgroundColor = [UIColor magentaColor];
    [foldBtn JHSetTitle:@"请选择" forState:UIControlStateNormal];
    foldBtn.delegate = self;
    [foldBtn JHSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
    [foldBtn JHSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
    foldBtn.foldBtnType = JHFoldButtonTypeRight;
    foldBtn.foldBtnResultBlock = ^(id obj) {
        NSLog(@"foldBtnResultBlock = %@", obj);
    };
    
    
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor grayColor];
    coverView.frame = CGRectMake(80, 150, 50, 50);
    
    
    [self.view addSubview:foldBtn];
    [self.view addSubview:coverView];
}

#pragma mark - JHFoldButtonDelegate
-(void)JHFoldButton:(JHFoldButton *)foldBtn didSelectObjc:(id)obj {
    NSLog(@"JHFoldButtonDelegate == %@", obj);
}

@end
