//
//  JHIrregularViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/4/3.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHIrregularViewController.h"
#import "JHIrregularLabel.h"

@interface JHIrregularViewController ()
@property (nonatomic, strong) JHIrregularLabel *irregularLabel;
@end

@implementation JHIrregularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.irregularLabel = [[JHIrregularLabel alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width * 0.5, 60)];
    self.irregularLabel.text  = @"这是一个不规则的label";
    self.irregularLabel.textAlignment = NSTextAlignmentCenter;
    self.irregularLabel.backgroundColor = [UIColor redColor];
    self.irregularLabel.textColor = [UIColor whiteColor];
    self.irregularLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:self.irregularLabel];
}
@end
