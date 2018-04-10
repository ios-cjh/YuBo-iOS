//
//  JHFoldButton.m
//  YUBODemo
//
//  Created by cjh on 2018/3/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHFoldButton.h"

static NSString *const cellID = @"cellID";

@interface JHFoldButton ()<UITableViewDelegate, UITableViewDataSource>{
    CGSize _showSize;
    BOOL _isTableFold;
    NSArray *_dataArray;
}
@property (strong, nonatomic) UIView *foldBackgroundView;
@property (strong, nonatomic) UIButton *foldBtn;
@property (strong, nonatomic) UITableView *foldTableView;
@end

@implementation JHFoldButton

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<NSString *>*)dataArray {
    if (self = [super init]) {
        self.frame = frame;
        _showSize = frame.size;
        _dataArray = dataArray;
        _jhTitleChanged = YES;
        _jhHeight = 200;
         [self setUI];
    }
    return self;
}

-(void)setUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
    NSString *title = nil;
    if (_dataArray.count > 0 && !title) {
        title = _dataArray[0];
    } else {
        title = @"选择";
    }
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
     [self addSubview:button];
    self.foldBtn = button;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _showSize.height, _showSize.width, 10)];
    bgView.backgroundColor = [UIColor blueColor];
    [self addSubview:bgView];
    self.foldBackgroundView = bgView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _showSize.height, _showSize.width, 0) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.delegate = self;
    tableView.rowHeight = 70;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.foldTableView = tableView;
}

-(void)buttonClick:(UIButton *)btn {
    NSLog(@"self.superview.subviews.lastObject = %@", self.superview.subviews.lastObject);
    NSLog(@"self.superview = %@", self.superview);
    
    if (self.superview == nil) return;
    if ([self.superview.subviews lastObject] != self) {
        [self.superview bringSubviewToFront:self];
    }
    
    btn.selected = !btn.selected;
    if (_isTableFold) {
        [self tableClose];// 关
    } else {
        [self tableOpen];// 开 首次点击来这里
    }
}

-(void)tableClose { // 关
    if (_isTableFold == NO) { // 如果已经关闭了  直接返回
        return;
    }
    
    _isTableFold = NO;
    // 缩小父视图容器，才能容纳子视图
    CGRect rect = self.frame;
    rect.size.height = rect.size.height - self.jhHeight;
    self.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tableViewF = self.foldTableView.frame;
        tableViewF.size.height = tableViewF.size.height - self.jhHeight;
        self.foldTableView.frame = tableViewF;
        
        CGRect backgroundViewF =  self.foldBackgroundView.frame;
        backgroundViewF.size.height = backgroundViewF.size.height - self.jhHeight;
        self.foldBackgroundView.frame = backgroundViewF;
    }];
}

-(void)tableOpen { // 开
    if (_isTableFold == YES) {
        return;
    }
    _isTableFold = YES;
    
    // 扩大父视图容器，才能容纳子视图
    CGRect rect = self.frame;
    rect.size.height = rect.size.height + self.jhHeight;
    self.frame = rect;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tableRect = self.foldTableView.frame;
        tableRect.size.height = tableRect.size.height + self.jhHeight;
        self.foldTableView.frame = tableRect;
        
        CGRect backgroundViewF =  self.foldBackgroundView.frame;
        backgroundViewF.size.height = backgroundViewF.size.height + self.jhHeight;
        self.foldBackgroundView.frame = backgroundViewF;
    }];
    
}

#pragma mark - 自定义按钮设置方法
/** 设置按钮的标题 */
- (void)JHSetTitle:(NSString*)title forState:(UIControlState)state {
    [self.foldBtn setTitle:title forState:state];
}
/** 设置按钮的标题颜色 */
-(void)JHSetTitleColor:(UIColor*)color forState:(UIControlState)state {
    [self.foldBtn setTitleColor:color forState:state];
}
/** 设置按钮的背景图片 */
- (void)JHSetBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.foldBtn setBackgroundImage:image forState:state];
}
/** 设置按钮的图片 */
- (void)JHSetImage:(UIImage *)image forState:(UIControlState)state {
    [self.foldBtn setImage:image forState:state];
}

#pragma mark - 重写属性setter方法
-(void)setFoldBtnType:(JHFoldBtnType)foldBtnType {
    _foldBtnType = foldBtnType;
    
    switch (foldBtnType) {
        case JHFoldButtonTypeNormal:
            
            break;
        case JHFoldButtonTypeRight:
        {
            //需要在外部修改标题背景色的时候将此代码注释
            self.foldBtn.titleLabel.backgroundColor = self.foldBtn.backgroundColor;
            self.foldBtn.imageView.backgroundColor = self.foldBtn.backgroundColor;
        
            CGSize titleSize = self.foldBtn.titleLabel.bounds.size;
            CGSize imageSize = self.foldBtn.imageView.bounds.size;
            CGFloat interval = 1.0;
            [self.foldBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [self.foldBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            // 图片位置
            [self.foldBtn setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + interval, 0, -(titleSize.width + interval))];
            // 文字位置
            [self.foldBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval)];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj = [_dataArray objectAtIndex:indexPath.row];
    
    // block回调结果
    if (self.foldBtnResultBlock) {
        self.foldBtnResultBlock(obj);
    }
    // 代理回调结果
    if (self.delegate && [self.delegate respondsToSelector:@selector(JHFoldButton:didSelectObjc:)]) {
        [self.delegate JHFoldButton:self didSelectObjc:obj];
    }
    
    if (self.jhTitleChanged) {
        [self JHSetTitle:obj forState:UIControlStateNormal];
    }
    
    [self buttonClick:self.foldBtn];
}







@end
