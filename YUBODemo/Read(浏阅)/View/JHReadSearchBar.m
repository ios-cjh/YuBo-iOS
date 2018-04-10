//
//  JHReadSearchBar.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/6.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHReadSearchBar.h"

@implementation JHReadSearchBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsBookmarkButton = YES;
        self.placeholder = @"请搜索漫画名称";
        self.tintColor = [UIColor colorWithRed:153 / 255.0 green:214 / 255.0 blue:93 / 255.0 alpha:1.0];
    }
    return self;
}

@end
