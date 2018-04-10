//
//  JHMessageModel.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHMessageModel.h"

static CGFloat const margin = 10.f;
static CGFloat const contentFont = 14.f;
static CGFloat const contentLabelY = margin + 30.f + margin; // 30是头像高度

@implementation JHMessageModel {
    CGFloat _cellHeight;
}

+ (instancetype)messageWithDic:(NSDictionary *)dic {// 字典转模型
    JHMessageModel *msgModel = [[self alloc] init];
    [msgModel setValuesForKeysWithDictionary:dic];
    return msgModel;
}

-(CGFloat)cellHeight { // 计算高度
    if (!_cellHeight) {
        // 宽度减去左右两边间距
        CGFloat contentW = [UIScreen mainScreen].bounds.size.width - (2 * margin);
        //计算文字的高度
        CGFloat contentH = [self.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:contentFont]} context:nil].size.height;
        _cellHeight = contentLabelY + contentH + margin;
        if (self.imageName.length) {
            UIImage *image = [UIImage imageNamed:self.imageName];
            CGFloat imageH = image.size.height;
            CGFloat imageW = image.size.width;
            _contentImageFrame = CGRectMake(margin, _cellHeight, imageW, imageH);
            _cellHeight += imageH + margin;
        }
    }
    return _cellHeight;
}




@end
