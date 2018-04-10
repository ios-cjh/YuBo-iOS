//
//  JHComicViewController.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/1.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHComicViewController : UIViewController
@property (nonatomic, copy) NSString *requestType;
- (instancetype)initWithRequestSearch:(BOOL)isSearch;
@property (nonatomic, assign, readonly) BOOL isSearch;

@end
