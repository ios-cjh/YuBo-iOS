//
//  GankNetApi.m
//  妹子
//
//  Created by cjj on 16/6/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHGankNetApi.h"
#import "AFNetworking.h"

@implementation JHGankNetApi
/**
 *  获取Gank数据接口
 *
 *  @param type      数据类型：福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
 *  @param pageSize  请求个数
 *  @param pageIndex 第几页
 */

+(void)getGankDataWithType:(NSString *)type pageSize:(NSUInteger)pageSize pageIndex:(NSInteger)pageIndex success:(void(^)(NSDictionary *dict))success failure:(void(^)(NSString *text))failure
{
    //获取网络数据
    NSString *url = [NSString stringWithFormat:@"http://gank.io/api/data/%@/%zd/%zd",type,pageSize,pageIndex];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[AFHTTPSessionManager manager] GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"----- %@",error);
    }];

}

+(void)getDataType:(JHNetType)type WithURL:(NSString *)url andParams:(NSDictionary *)params success:(void(^)(id result))success failure:(void(^)(NSString *msg))failure {
    switch (type) {
        case GET: {
            [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(@"gg");
            }];
            break;
        }
        case POST: {
            break;
        }
        default:
            break;
    }
}

@end
