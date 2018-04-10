//
//  JHMyCell.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/3/16.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHMyCell.h"

@interface JHMyCell()
{
    BOOL isOK;
    UIView * myView;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation JHMyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    myView = [[UIView alloc]initWithFrame:CGRectMake(180, 170, 100, 40)];
    myView.backgroundColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:118/255.0 alpha:1];
    [self.viewForBaselineLayout addSubview:myView];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame=CGRectMake(0, 0, 50, 40);
    [btn1 setTintColor:[UIColor whiteColor]];
    [btn1 setTitle:@"赞" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"AlbumInformationLikeHL"] forState:UIControlStateNormal];
    [myView addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame=CGRectMake(50, 0, 50, 40);
    [btn2 setTintColor:[UIColor whiteColor]];
    [btn2 setImage:[UIImage imageNamed:@"AlbumCommentSingleBigHL"] forState:UIControlStateNormal];
    [btn2 setTitle:@"评论" forState:UIControlStateNormal];
    [myView addSubview:btn2];
    myView.backgroundColor = [UIColor redColor];
    myView.hidden=YES;
}

-(void)setCellInfo {
    
    NSString *str = @"是[爱你]不是对生活不太满意，很久没有笑过又不知为何。既然不快乐又不喜欢这里，不如一路向西 去大理。路程有点波折，空气有点稀薄。景色越辽阔 心里越寂寞，不知道谁在 何处等待，不知道后来的后来。[爱你][兔子]";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    NSArray *result = [self tttString:str]; // 数组存着【爱你】
    for (NSInteger i = result.count - 1; i>=0; i--) {   // 数组存放【爱你】
        NSTextCheckingResult *r = result[i];
        
        NSString *tempString = [str substringWithRange:r.range];//打印[爱你]
        NSString *tempStr = [self cutStr:tempString]; //爱你
        
        for (int j = 0; j < arr.count; j++) {
            NSDictionary *dic = arr[j];
            NSString *dictStr = dic[@"chs"];
            if ( [dictStr isEqualToString:@"[爱你]"] ||  [dictStr isEqualToString:@"[兔子]"]) {
                // 取出[爱你]的图片
                NSString *imageNameStr = dic[@"png"];
                NSLog(@"=== %@", imageNameStr);
                UIImage *image = [UIImage imageNamed:imageNameStr];
                
                UIImage *userIcon = [self curImage:image toSize:CGSizeMake(15, 15)];
                
                NSTextAttachment *attachment = [NSTextAttachment new];
                attachment.image = userIcon;
                NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:attachment];
                [attributedStr replaceCharactersInRange:r.range withAttributedString:imageAtt];
                
                self.userDescriptionLabel.attributedText = attributedStr;
                break;
            }
        }
    }
    self.timeLabel.text = [self date];
}

-(NSString *)date
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    
    return currentDateStr;
}
-(UIImage *)curImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return currentImage;
}


// [爱你] ->爱你
-(NSString *)cutStr:(NSString *)str {
    NSString *cutStr = [str substringWithRange:NSMakeRange(1, str.length - 2)];
    return cutStr;
}

-(NSArray *)tttString:(NSString *)str {
    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError * error;
    // 正则表达式对象
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arr = [re matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    return arr;
}

@end
