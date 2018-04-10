//
//  JHPrettyPicCell.m
//  YUBODemo
//
//  Created by cjh on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHPrettyPicCell.h"
#import "JHPrettyPicDataModel.h"

@interface JHPrettyPicCell()
    
@property (nonatomic, weak) UIView *containView;
@property (nonatomic, weak) UILabel *timeLabel;
@end

@implementation JHPrettyPicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *kcell = @"cellid";
    JHPrettyPicCell *picCell = [tableView dequeueReusableCellWithIdentifier:kcell];
    if(picCell == nil) {
        picCell = [[JHPrettyPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcell];
        picCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return picCell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}
    
- (void)initView {
    UIImageView *picImageView = [[UIImageView alloc] init];
    picImageView.contentMode = UIViewContentModeCenter;
    self.picImageView = picImageView;
    picImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:picImageView];
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 5, 10);
    [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
    UIView *containView = [UIView new];// 65，71，79
    self.containView = containView;
    containView.backgroundColor = RGBA(65, 71, 79, 0.8f);
    [self.picImageView addSubview:containView];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImageView.mas_left);
        make.right.equalTo(self.picImageView.mas_right);
        make.bottom.equalTo(self.picImageView.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    UILabel *timeLabel = [UILabel new];
    self.timeLabel = timeLabel;
    [self.containView addSubview:timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView.mas_left).with.offset(15);
        make.bottom.equalTo(self.containView.mas_bottom);
    }];
}

-(void)setPrettyPicDataModel:(JHPrettyPicDataModel *)prettyPicDataModel {
    _prettyPicDataModel = prettyPicDataModel;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:prettyPicDataModel.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIGraphicsBeginImageContextWithOptions(_picImageView.frame.size, YES, 0.0);
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
        self.picImageView.image = currentImage;
        
        UIGraphicsEndImageContext();
    }];

    NSString *publishedText = @"发布时间:";
    NSString *publishedTime = prettyPicDataModel.publishedAt;
    NSString *correntTimeStr = [publishedTime componentsSeparatedByString:@"T"].firstObject;
    
    NSString *totalStr = [NSString stringWithFormat:@"%@%@",publishedText,correntTimeStr];
    NSMutableAttributedString *timeLableMAttr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [timeLableMAttr addAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:[totalStr rangeOfString:publishedText]];

    [timeLableMAttr addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]} range:[totalStr rangeOfString:correntTimeStr]];
    
    self.timeLabel.attributedText = timeLableMAttr;
}
    
    
    




@end
