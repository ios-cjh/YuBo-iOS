//
//  JHMineViewController.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHMineViewController.h"

#import "JHContactViewController.h"
#import "UIImage+Color.h"
#import "JHProgressHUD.h"


static NSString *const kContactCell      = @"ContactCell";
static NSString *const kFeedbackCell     = @"FeedbackCell";
static NSString *const kSettingCell      = @"SettingCell";
static NSString *const kCacheCell        = @"CacheCell";
static NSString *const kPayCell          = @"PayCell";
static NSString *const kSuggestionCell   = @"SuggestionCell";


@interface CacheCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation CacheCell
@end

@interface JHMineViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView * headerView;

@property (nonatomic, strong) NSMutableArray *cellIDArr;
@end

@implementation JHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"华联第一美林梦瑶";
    [self initView];
    [self initCellID];
    [self initData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void) initData
{
    [self.tableView reloadData];
    NSLog(@"= = = %ld", (long)JHCacheTool.fileSizeOfCache);
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)initView {
        //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.headerView = [[UIImageView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerView.image = [UIImage imageNamed:@"linm.jpeg"];
    
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    self.navigationController.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellIDArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jj" ];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jj"];
        
        
        if (indexPath.section == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"❤️love林林"];//通讯录
        } else if (indexPath.section == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"❤️❤️love梦梦"]; // 意见反馈
        } else if (indexPath.section == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"❤️❤️❤️love瑶瑶~"]; // 设置
        } else if (indexPath.section == 3) {
            cell.textLabel.text = [NSString stringWithFormat:@"💖❤️用你给我的翅膀飞，再高都不会累~"];//JHCacheTool.fileSizeOfCache 清除缓存
        } else if (indexPath.section == 4) {
            cell.textLabel.text = [NSString stringWithFormat:@"💖💖from cjh 😘 あなたのことが好きです"];
        } else if (indexPath.section == 5) {
            cell.textLabel.text = [NSString stringWithFormat:@"💕💖🎓🎓 😊 love UU"];
        } else {
            cell.textLabel.text = @"sdk";
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.backgroundColor = randomColor;
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 下拉动画放大图片
    CGRect newFrame = self.headerView.frame;
    CGFloat settingViewOffsetY = 50 - scrollView.contentOffset.y;
    newFrame.size.height = settingViewOffsetY;
    if (settingViewOffsetY < 50) {
        newFrame.size.height = 50;
    }
    self.headerView.frame = newFrame;
    
    // 导航栏渐变
    CGPoint offset = scrollView.contentOffset;
    CGFloat denominator = (120 - 64) / 2;
//    CGFloat offsetY = offset.y - denominator; // 超过一半渐变
    CGFloat alpha = (offset.y - denominator) / denominator > 0.99 ? 0.99 : (offset.y - denominator) / denominator;
    alpha = alpha < 0 ? 0 : alpha;
    
    // 153 214 93
    UIImage *img = [UIImage imageWithColor:[UIColor colorWithRed:153 / 255.0 green:214 / 255.0 blue:93 / 255.0 alpha:alpha] size:CGSizeMake(1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:img];
}



#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JHContactViewController *contactVc = [JHContactViewController new];
        contactVc.title = @"DJ lin";//通讯录
        contactVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contactVc animated:YES];
    } else if (indexPath.section == 1) {
        //JHFeedbackViewController
        JHFeedbackViewController *feedbackVc = [JHFeedbackViewController new];
        feedbackVc.title = @"LMY";// 意见反馈
        feedbackVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedbackVc animated:YES];
    } else if (indexPath.section == 2) {
        NSLog(@"白痴小姐");// 登录和注销
    } else if (indexPath.section == 3) {
        [JHProgressHUD showOnlyTextInView:tableView text:@"清除缓存中..."];
      
        [JHCacheTool clearCache];
        UITableViewCell *cell =  tableView.visibleCells[indexPath.section];
        cell.textLabel.text = @"jinghuadj";
        [self.tableView reloadData];

    } else {
        NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
}

-(void)initCellID
{
    self.cellIDArr = [NSMutableArray array];
    [self.cellIDArr addObject:kContactCell];
    [self.cellIDArr addObject:kFeedbackCell];
    [self.cellIDArr addObject:kSettingCell];
    [self.cellIDArr addObject:kCacheCell];
    [self.cellIDArr addObject:kPayCell];
    [self.cellIDArr addObject:kSuggestionCell];
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
        _tableView.contentInset = UIEdgeInsetsMake(300, 0, 60, 0);
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}


@end
