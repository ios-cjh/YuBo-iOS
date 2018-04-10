//
//  JHPrettyViewController.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHPrettyViewController.h"
#import "JHPrettyPicCell.h"
#import "JHGankNetApi.h"
#import "JHNetworkTool.h"

#import "JHGankNetApi.h"

#import "JHPrettyPicDataModel.h"
#import "JHDataBase.h"


static NSString *const kJHPrettyPicCell = @"JHPrettyPicCell";
static NSString *const kType = @"福利";
static const NSInteger kPageSize = 20;
static NSUInteger flag = 0;

@interface JHPrettyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/**
 * 第几页
 */
@property (nonatomic, assign) NSUInteger pageIndex;
    
@property (nonatomic, strong) NSMutableArray *PrettyDataArray;


@end

@implementation JHPrettyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    // 首次从偏好设置获取为空No
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstTime"] == NO) {
        [self loadData];
    } else {
        self.PrettyDataArray = [[JHDataBase shareDataBase] getAllPrettyPicDataModel];
        [self.tableView reloadData];
    }
    
}

- (void)initUI{
    [self.view addSubview:self.tableView];
    
    self.tableView.rowHeight = 200;
    
}

#pragma mark - data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.PrettyDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHPrettyPicCell *picCell = [JHPrettyPicCell cellWithTableView:tableView];
    picCell.prettyPicDataModel = self.PrettyDataArray[indexPath.row];
    return picCell;
}

-(void)loadData
{
    if (![JHNetworkTool isExistenceNetwork]) {
        [JHProgressHUD showOnlyTextInView:self.view text:@"请检查网络设置"];
        return;
    }
    
    [JHNetworkTool showNetWorkActivityIndicator:YES];
    _pageIndex = 1;
    flag = 0;
    [JHGankNetApi getGankDataWithType:kType pageSize:kPageSize pageIndex:_pageIndex success:^(NSDictionary *dict) {
        if (flag == 1) {
            return ;
        }

        // 使用MJExtension进行字典转模型
        self.PrettyDataArray = [JHPrettyPicDataModel mj_objectArrayWithKeyValuesArray:dict[@"results"]];// (字典数组转模型数组)
        
        for (JHPrettyPicDataModel *model in self.PrettyDataArray) {
            [[JHDataBase shareDataBase] addPrettyDatas:model];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    } failure:^(NSString *text) {
        [JHNetworkTool showNetWorkActivityIndicator:NO];
    }];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *items = [NSMutableArray new];
    JHPrettyPicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    JHPrettyPicDataModel *model = self.PrettyDataArray[indexPath.row];
    KSPhotoItem *item =[KSPhotoItem itemWithSourceView:cell.picImageView imageUrl:[NSURL URLWithString:model.url]];
    [items addObject:item];
    
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:0];
    [browser showFromViewController:self];
}



#pragma mark - 懒加载
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        //不要分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        
        
        _tableView.dataSource = self;
        if(systemVersion >=11.0) { 
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 60 + 34, 0);
        } else {
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
        }
    }
    return _tableView;
}


@end
