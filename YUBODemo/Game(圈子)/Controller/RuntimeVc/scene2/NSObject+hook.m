//
//  NSObject+hook.m
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "NSObject+hook.h"
#import <objc/runtime.h>

const char *kPropertyListKey = "kPropertyListKey";
@implementation NSObject (hook)
+(NSArray *)hh_objcProperties {
    // 获取关联对象
    NSArray *pList = objc_getAssociatedObject(self, kPropertyListKey);
    if (pList) {
        return pList;
    }
    
    unsigned int outCount = 0;
    
    NSMutableArray *mtArray = [NSMutableArray array];
   
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        //从数组获得属性
        objc_property_t property = propertyList[i];
        // 从属性获得名称
        const char *propertyName_C = property_getName(property);
        // 将c字符串转oc字符串
        NSString *propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [mtArray addObject:propertyName_OC];
    }
    objc_setAssociatedObject(self, kPropertyListKey, mtArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    free(propertyList);
    return mtArray.copy;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    // 获取self的属性列表
    NSArray *propertyList = [self hh_objcProperties];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([propertyList containsObject:key]) {
            [objc setValue:obj forKey:key];
        }
    }];
    return objc;
}
@end
