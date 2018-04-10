//
//  JHListContentModel.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/5.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHListContentModel : NSObject

@property (nonatomic, strong) NSNumber *comics_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, strong) NSNumber *created_at;
@property (nonatomic, strong) NSNumber *is_favourite;
@property (nonatomic, strong) NSNumber *label_id;
@property (nonatomic, strong) NSNumber *likes_count;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSNumber *updated_at;
@property (nonatomic, strong) NSNumber *user_id;

@property (nonatomic, copy) NSString *aID;
@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, copy) NSString *aDescription;
@property (nonatomic, copy) NSString *discover_image_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vertical_image_url;

@property (nonatomic, strong) NSMutableArray *comics;

@end
