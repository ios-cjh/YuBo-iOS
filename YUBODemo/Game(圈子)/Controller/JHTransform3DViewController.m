//
//  JHTransform3DViewController.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/3/17.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHTransform3DViewController.h"

@interface JHTransform3DViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewArray;
@property (nonatomic, assign) CGPoint diceAngle;
@end

@implementation JHTransform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 给contentview添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewTransform:)];
    [self.contentView addGestureRecognizer:pan];
    
    
    CATransform3D diceTransform = CATransform3DIdentity;
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 75);
    [self addFace:0 withTransform:diceTransform];
    
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 75, 0, 0);
    diceTransform = CATransform3DRotate(diceTransform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:diceTransform];
    
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -75, 0);
    diceTransform = CATransform3DRotate(diceTransform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:diceTransform];

    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 75, 0);
    diceTransform = CATransform3DRotate(diceTransform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:diceTransform];

    diceTransform = CATransform3DTranslate(CATransform3DIdentity, -75, 0, 0);
    diceTransform = CATransform3DRotate(diceTransform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:diceTransform];

    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -75);
    diceTransform = CATransform3DRotate(diceTransform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:diceTransform];
}

-(void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {

    UIImageView *picImageView = (UIImageView *)self.imageViewArray[index];
    picImageView.layer.transform = transform;
    picImageView.layer.doubleSided = NO;
    
    CGSize containerSize = self.contentView.bounds.size;
    picImageView.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2);
    [self.contentView addSubview:picImageView];
}

- (void)viewTransform:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:self.contentView];
    CGFloat angleX = self.diceAngle.x + (point.x/50);
    CGFloat angleY = self.diceAngle.y + (point.y/50);

    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 5000;
    transform = CATransform3DRotate(transform, angleX, 0, 1, 0);
    transform = CATransform3DRotate(transform, angleY, 1, 0, 0);
    self.contentView.layer.sublayerTransform = transform;

    if (sender.state == UIGestureRecognizerStateEnded) {
        self.diceAngle = CGPointMake(angleX, angleY); // 存储最后一个点
    }
}


@end
