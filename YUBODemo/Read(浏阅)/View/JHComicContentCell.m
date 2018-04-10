//
//  JHComicContentCell.m
//  YUBODemo
//
//  Created by cjh on 2018/2/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHComicContentCell.h"
#import "JHListContentModel.h"

@interface JHComicContentCell()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@end

@implementation JHComicContentCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setContentModel:(JHListContentModel *)contentModel {
    _contentModel = contentModel;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.cover_image_url]];
    self.titleLabel.text = contentModel.title;
    self.desLabel.text = contentModel.aDescription;
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %d", contentModel.likes_count.intValue] forState:UIControlStateNormal];
}


@end
