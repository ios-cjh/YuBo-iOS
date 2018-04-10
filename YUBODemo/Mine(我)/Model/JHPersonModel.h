//
//  JHPersonModel.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/16.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHPersonModel : NSObject
@property (nonatomic,copy) NSString *firstName;
@property (nonatomic,copy) NSString *lastName;
@property (nonatomic,copy) NSString *name1;
@property (nonatomic,copy) NSString *phoneNumber;
@property(nonatomic,copy)  NSString *phonename;
@property(nonatomic,copy)  NSString *friendId;
@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger recordID;
@property BOOL rowSelected;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@property(nonatomic, strong) NSData *icon;//图片

@end
