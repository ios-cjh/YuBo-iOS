//
//  JHComicViewController.m
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/2/1.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHComicViewController.h"
#import "JHComicContentCell.h"
#import "JHGankNetApi.h"
#import "JHListContentModel.h"

static NSString *const kcellID = @"cellid";

@interface JHComicViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger _pageIndex;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *listContentArray;
@end

@implementation JHComicViewController

#pragma mark - 懒加载
-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JHComicContentCell class]) bundle:nil] forCellWithReuseIdentifier:kcellID];
    }
    return _collectionView;
}


#pragma mark - 外部
- (instancetype)initWithRequestSearch:(BOOL)isSearch {
    if (self = [super init]) {
        _isSearch = isSearch;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
    [self requestMoreData];
}

-(void)initSubView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];

}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"listContentArray == %lu", (unsigned long)self.listContentArray.count);
    return self.listContentArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JHComicContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellID forIndexPath:indexPath];
   
    cell.contentModel = self.listContentArray[indexPath.item];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(kSCREEN_WIDTH,90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
}

#pragma mark - 内部
-(void)loadMoreData {
    _pageIndex = self.listContentArray.count;
    [self requestMoreData];
}

-(void)requestMoreData {
    
    NSString *urlStr = @"";
    NSDictionary *paramsDict;
    NSLog(@"== %@", self.requestType);
    
    if (_isSearch) {
        urlStr = @"http://api.kuaikanmanhua.com/v1/topics/search";
        paramsDict = @{@"limit": @20,
                      @"offset": @(_pageIndex),
                      @"keyword": _requestType};
    }else{
        urlStr = @"http://api.kuaikanmanhua.com/v1/topics";
        paramsDict = @{
                      @"limit": @20,
                      @"offset": @(_pageIndex),
                      @"tag": _requestType,
                       };
    }
    
    __weak typeof(self) weakself = self;
    
    [JHGankNetApi getDataType:GET WithURL:urlStr andParams:paramsDict success:^(id result) {
        
        __strong typeof(weakself) strongself = weakself;

        NSMutableArray *listContentArray = [JHListContentModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"topics"]];
        if (_pageIndex == 0) {
            if (listContentArray.count == 0 && self.isSearch) {
                [JHProgressHUD showOnlyTextInView:self.view text:@"亲^_^ 没有搜到内容喔"];

            }
            strongself.listContentArray = listContentArray;
        }
    } failure:^(NSString *msg) {
        NSLog(@"f");
    }];
}

-(void)setListContentArray:(NSMutableArray *)listContentArray {
    _listContentArray = listContentArray;
    [self.collectionView reloadData];
}



@end
