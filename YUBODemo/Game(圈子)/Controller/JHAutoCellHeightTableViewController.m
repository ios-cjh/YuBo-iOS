//
//  JHAutoCellHeightTableViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/4/2.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHAutoCellHeightTableViewController.h"
#import "JHMessageModel.h"
#import "JHMessageCell.h"

static NSString *const cellID = @"cellID";

@interface JHAutoCellHeightTableViewController ()
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation JHAutoCellHeightTableViewController

-(NSArray *)dataList {
    if (!_dataList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
        NSArray *originArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mArry = [NSMutableArray array];
        for (NSDictionary *dict in originArray) {
            JHMessageModel *model = [JHMessageModel messageWithDic:dict];
            [mArry addObject:model];
        }
        [mArry addObjectsFromArray:mArry];
        _dataList = mArry;
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JHMessageCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.messageModel = self.dataList[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHMessageModel *model = self.dataList[indexPath.row];
    return model.cellHeight;
}

@end
