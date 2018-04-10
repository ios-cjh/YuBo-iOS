//
//  JHReadViewController.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHReadViewController.h"
#import "DBSphereView.h"
#import "JHComicViewController.h"
#import "JHTagBtn.h"
#import "JHReadSearchBar.h"


@interface JHReadViewController () <UISearchBarDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *searchNameArray;
@property (nonatomic, strong) DBSphereView *sphereView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation JHReadViewController

#pragma mark - 懒加载
-(NSArray *)searchNameArray {
    if (_searchNameArray == nil) {
        _searchNameArray = [NSArray new];
    }
    return _searchNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone; // 导航栏底部开始布局
    [self getData];
    
    [self initsubView];
}


#pragma mark - 内部初始化
-(void)initsubView {
    JHReadSearchBar *searchBar = [[JHReadSearchBar alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 44)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), kSCREEN_WIDTH, kSCREEN_HIGHT - 44)];
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
  
    
    CGFloat bounds_Width = MIN(kSCREEN_WIDTH, (kSCREEN_HIGHT - CGRectGetMaxY(searchBar.frame)));
    self.sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), bounds_Width, bounds_Width)];
    NSMutableArray *btnArr = [NSMutableArray new];
    for (int i = 0; i < 50; i++) {
        JHTagBtn *tagBtn = [[JHTagBtn alloc] initWithFrame:CGRectMake(0, 0, 85, 20)];
        [tagBtn setTitle:self.searchNameArray[i * 4 + arc4random()% 4] forState:UIControlStateNormal];
        [tagBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:tagBtn];
        [self.sphereView addSubview:tagBtn];
    }
    
//    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [self.sphereView addGestureRecognizer:panGest];
    [self.sphereView setCloudTags:btnArr];
    [scrollView addSubview:self.sphereView];
}

-(void)getData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchNamePlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *paramsDict = dict[@"online_params"];
    NSString *comicNameStr = paramsDict[@"KeyWord"];
    self.searchNameArray = [comicNameStr componentsSeparatedByString:@","];
}

#pragma mark - 处理事件
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self jumpToComicWith:searchBar.text];
}


-(void)buttonPressed:(UIButton *)btn {
    [self jumpToComicWith:btn.titleLabel.text];
}

-(void)jumpToComicWith:(NSString *)params {
    [self.searchBar resignFirstResponder];
    JHComicViewController *comicVc = [[JHComicViewController alloc] initWithRequestSearch:YES];
    comicVc.requestType = params;
    comicVc.title = params;
    [[JHJumpVcManager shareInstance].navigationVc pushViewController:comicVc animated:YES];
}

//-(void)pan:(UIPanGestureRecognizer *)pangest {
////    [[UIApplication sharedApplication] performSelector:NSSelectorFromString(@"resignFirstResponder")];
//    [[UIApplication sharedApplication] sendAction:NSSelectorFromString(@"resignFirstResponder") to:nil from:nil forEvent:nil];
//}



@end
