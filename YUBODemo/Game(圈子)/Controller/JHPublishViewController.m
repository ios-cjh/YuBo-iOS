//
//  JHPublishViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/1/22.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHPublishViewController.h"
#import "UIColor+GradientLayer.h"

#import "JHCAEmitterLayerView.h"
#import "JHSnowView.h"
#import "JHRippleView.h"
#import "JHPresentationPublishController.h"

@interface JHPublishViewController ()
@property (nonatomic, strong) JHCAEmitterLayerView *snowView;
@end

@implementation JHPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}
#pragma MARK - 内部
-(void)initSubView {
    self.modalPresentationCapturesStatusBarAppearance = NO;
    // 添加雪花
    [self initSnowView];
    // 添加水波纹
    [self initRippleView];
}

- (void)initSnowView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat height = 140;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) / 2;
    CGFloat y = 64 + 20;
    JHCAEmitterLayerView *snowView = [[JHSnowView alloc] initWithFrame:(CGRectMake(x, y, width, height))];
    
    [snowView.layer addSublayer:[UIColor setGradientLayerInView:snowView withFromColor:RGBA(131, 111, 255, 0.8) toColor:RGBA(138, 43, 226, 0.5)]];
    [self.view addSubview:snowView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [snowView addGestureRecognizer:tapGes];
    self.snowView = snowView;
    [snowView show];
    
}

- (void)initRippleView {
    // #FF6A6A #FF8247
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
    CGFloat height = 140;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - width) / 2;
    CGFloat y = CGRectGetMaxY(self.snowView.frame) + 20;
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    containView.layer.cornerRadius = 7;
    containView.layer.masksToBounds = YES;
    [containView.layer addSublayer:[UIColor setGradientLayerInView:containView withFromColor:RGBA(255, 69, 69, 1.0) toColor:RGBA(240, 128, 128, 1.0)]];
    
    CGFloat maxRadius = containView.frame.size.width;
    JHRippleView *rippleView = [[JHRippleView alloc] initMinRadius:15 maxRadius:maxRadius];
    rippleView.rippleCount = 2;
    rippleView.rippleDuration = 5;
    rippleView.rippleColor = [UIColor clearColor];
    rippleView.borderWidth = 20;
    rippleView.borderColor = [UIColor whiteColor];
    [rippleView startAnimation];
    CGFloat rippleW = 80;
    CGFloat rippleH = 80;
    CGFloat rippleX = containView.frame.size.width - 80 - 30;
    CGFloat rippleY = ( containView.frame.size.height - 80) / 2;
    rippleView.frame = CGRectMake(rippleX, rippleY, rippleW, rippleH);
    [self.view addSubview:containView];
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRippleViewAction)];
    [containView addGestureRecognizer:tapRec];
    [containView addSubview:rippleView];
}

#pragma mark - 事件处理
-(void)tapAction {
    JHPresentationPublishController *presentPubVc = [JHPresentationPublishController new];
    presentPubVc.view.frame = CGRectMake(0, 40, kSCREEN_WIDTH, kSCREEN_HIGHT - 20);
    presentPubVc.view.backgroundColor = [UIColor orangeColor];
    [self presentViewController:presentPubVc animated:YES completion:nil];
}
-(void)tapRippleViewAction {
    JHMultiFunctionTableViewController *vc = [JHMultiFunctionTableViewController new];
    vc.title = @"多功能实现列表";
    [[[JHJumpVcManager shareInstance] navigationVc] pushViewController:vc animated:YES];
}

@end
