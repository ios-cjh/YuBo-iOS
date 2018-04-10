//
//  JHContentCell.m
//  YUBODemo
//
//  Created by cjh on 2018/3/17.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHContentCell.h"

@interface JHContentCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JHContentCell

-(void)setCellInfo {
    self.userIconImageView.image = [UIImage imageNamed:@"me"];
    [self.userNameBtn setTitle:@"LMY" forState:UIControlStateNormal];
    NSString *textStr = @"梦为努力浇了水，\n爱在背后往前推，\n当我抬起头儿才发觉，我是不是忘了谁，累到整夜不能睡，夜色哪里都是美，一定有个人，她躲过避过闪过瞒过，她是谁，她是谁";
    textStr = [textStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.descriLabel.text = textStr;
    self.contentHeight = [self.descriLabel.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size.height;
    
    self.timeLabel.text = [self date];
}
-(NSString *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}


@end
