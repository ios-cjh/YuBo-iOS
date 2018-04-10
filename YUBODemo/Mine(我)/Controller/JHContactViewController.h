//
//  JHContactViewController.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/15.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHContactViewController : UIViewController{
NSArray *_dataArray;
BOOL _isRelate;

}
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@end
