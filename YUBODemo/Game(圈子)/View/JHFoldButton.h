//
//  JHFoldButton.h
//  YUBODemo
//
//  Created by cjh on 2018/3/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHFoldButton;
@protocol JHFoldButtonDelegate <NSObject>
-(void)JHFoldButton:(JHFoldButton *)foldBtn didSelectObjc:(id)obj;
@end

typedef NS_ENUM(NSInteger, JHFoldBtnType) {
    JHFoldButtonTypeNormal = 0,//
    JHFoldButtonTypeRight  = 1,//图片在右
};

typedef void(^FoldBtnBlock)(id obj);

@interface JHFoldButton : UIView

/** 以block形式回调选中结果 */
@property (nonatomic, copy) FoldBtnBlock foldBtnResultBlock;
/** 以代理形式回调选中结果 */
@property (nonatomic, weak)id <JHFoldButtonDelegate> delegate;

/** 设置按钮的样式*/
@property (nonatomic, assign) JHFoldBtnType foldBtnType;

/** 选择后是否改变title为选择的内容,默认YES */
@property (assign,nonatomic)BOOL jhTitleChanged;
/** 展开列表的高度 默认 200 */
@property (assign,nonatomic)CGFloat jhHeight;


-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<NSString *>*)dataArray;
/** 设置按钮的标题 */
- (void)JHSetTitle:(NSString*)title forState:(UIControlState)state;
/** 设置按钮的标题颜色 */
-(void)JHSetTitleColor:(UIColor*)color forState:(UIControlState)state ;
/** 设置按钮的背景图片 */
- (void)JHSetBackgroundImage:(UIImage *)image forState:(UIControlState)state;
/** 设置按钮的图片 */
- (void)JHSetImage:(UIImage *)image forState:(UIControlState)state;

@end
