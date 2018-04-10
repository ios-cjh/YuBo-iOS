//
//  JHMessageCell.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHMessageCell.h"
#import "JHMessageModel.h"


@interface JHMessageCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) UIImageView *contentImageView; // 内容头像。
@end

@implementation JHMessageCell

-(UIImageView *)contentImageView {
    if (_contentImageView == nil) {
        _contentImageView = [UIImageView new];
        [self.contentView addSubview:_contentImageView];
    }
    return _contentImageView;
}

-(void)setMessageModel:(JHMessageModel *)messageModel {
    _messageModel = messageModel;
    self.contentLabel.text = messageModel.content;
    if (messageModel.imageName.length) {
        self.contentImageView.hidden = NO;
        self.contentImageView.frame = messageModel.contentImageFrame;
        self.contentImageView.image = [UIImage imageNamed:messageModel.imageName];
        
    } else {
        self.contentImageView.hidden = YES;
    }
}


@end
