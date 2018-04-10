//
//  JHRuntimeTableViewController.m
//  YUBODemo
//
//  Created by cjj on 2018/4/9.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHRuntimeTableViewController.h"
#import "JHAddPropertyToCategoryVC.h"
#import "JHDictToModelVC.h"


@interface JHRuntimeTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation JHRuntimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _dataSource = @[@"1.动态给分类添加属性",
                    @"2.字典转模型",
                    @"3.获取所有的私有属性和方法",
                    @"4.对私有属性修改",
                    @"5.归档解档",
                    @"6.动态添加方法"
                    ];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellIdentifier = @"cellIdentifier";


     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

     //2. 判断是否有可重用的，如果没有，则自己创建
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
     }


     cell.textLabel.text = _dataSource[indexPath.row];

     tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            JHAddPropertyToCategoryVC *vc = [JHAddPropertyToCategoryVC new];
            [[[JHJumpVcManager shareInstance] navigationVc] pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            JHDictToModelVC *vc = [JHDictToModelVC new];
            [[[JHJumpVcManager shareInstance] navigationVc] pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}



@end
