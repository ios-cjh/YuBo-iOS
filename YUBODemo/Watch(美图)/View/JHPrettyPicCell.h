//
//  JHPrettyPicCell.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UITableView;
@class JHPrettyPicDataModel;
@interface JHPrettyPicCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) JHPrettyPicDataModel *prettyPicDataModel;
@property (nonatomic, weak) UIImageView *picImageView;

@end
