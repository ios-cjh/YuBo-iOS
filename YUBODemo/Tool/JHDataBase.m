//
//  JHDataBase.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/7.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHDataBase.h"
#import "FMDB.h"

static JHDataBase *dataBaseShareInstance = nil;

@interface JHDataBase() <NSCopying, NSMutableCopying>{
    FMDatabase *_db;
}
@end


@implementation JHDataBase

+(instancetype) shareDataBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (dataBaseShareInstance == nil) {
            dataBaseShareInstance = [[self alloc] init];
            [dataBaseShareInstance initDataBase];
        }
    });
    return dataBaseShareInstance;
}

// 初始化数据库， 并创建表单
-(void)initDataBase {
    // document目录路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [path stringByAppendingPathComponent:@"prettyData.sqlite"];
    
    // 实例化db对象
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    
    // 创表 CREATE TABLE IF NOT EXISTS
    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS prettyDataTable('_id' text, 'source' text,'who' text,'publishedAt' text,'createdAt' text,'type' text,'desc' text,'url' text PRIMARY KEY)";
    BOOL success = [_db executeUpdate:sqlStr];
    
    if (success) {
        NSLog(@"创表成功");
    } else {
        NSLog(@"创表失败");
    }
    
    [_db close];
}

-(void)addPrettyDatas:(JHPrettyPicDataModel *)prettyPicDataModel {
    [_db open];
    [_db executeUpdate:@"PRAGMA foreign_keys=ON;"];
    BOOL success = [_db executeUpdate:@"INSERT INTO prettyDataTable(_id,source,who,publishedAt,createdAt,type,desc,url)VALUES(?,?,?,?,?,?,?,?)", prettyPicDataModel._id,prettyPicDataModel.source,prettyPicDataModel.who, prettyPicDataModel.publishedAt, prettyPicDataModel.createdAt,prettyPicDataModel.type, prettyPicDataModel.desc,prettyPicDataModel.url];
    if (success) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    
    [_db close];
}

- (NSMutableArray *)getAllPrettyPicDataModel {
    [_db open];
    
    NSMutableArray *dataArray = [NSMutableArray new];
    
    
    
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM prettyDataTable"];
    while ([resultSet next]) {
        JHPrettyPicDataModel *model = [JHPrettyPicDataModel new];
        model.url = [resultSet stringForColumn:@"url"];
        model.source = [resultSet stringForColumn:@"source"];
        model.who = [resultSet stringForColumn:@"who"];
        model.publishedAt = [resultSet stringForColumn:@"publishedAt"];
        model.createdAt = [resultSet stringForColumn:@"createdAt"];
        model.type = [resultSet stringForColumn:@"type"];
        model.desc = [resultSet stringForColumn:@"desc"];
        model.url = [resultSet stringForColumn:@"url"];
        [dataArray addObject:model];
    }
    
    [_db close];
    return dataArray;
}

#pragma mark - 内部单例

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (dataBaseShareInstance == nil) {
        dataBaseShareInstance = [super allocWithZone:zone];
    }
    return dataBaseShareInstance;
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}



@end
