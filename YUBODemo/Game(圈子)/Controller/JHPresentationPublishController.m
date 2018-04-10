//
//  JHPresentationPublishController.m
//  YUBODemo
//
//  Created by cjh on 2018/2/8.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHPresentationPublishController.h"
#import "JHBottomView.h"

@interface JHPresentationPublishController ()
@property (weak, nonatomic) IBOutlet JHBottomView *bottomView;

@end

@implementation JHPresentationPublishController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *statusView  = [UIView new];
    statusView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 20);
    statusView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:statusView];
    
    self.bottomView.frame = CGRectMake(0, 200, kSCREEN_WIDTH, 200);
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [self.bottomView show];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden {
    return NO;
}
- (IBAction)closeVCView:(UIButton *)sender {
    [self.bottomView closeMyVcView:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
