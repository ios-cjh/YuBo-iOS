//
//  JHContactViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/1/15.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHContactViewController.h"
#import "JHPersonModel.h"
#import "JHAddressBook.h"


static NSString *const kleftTableViewCell = @"leftTableViewCell";
static NSString *const krightTableViewCell = @"rightTableViewCell";
//
@interface leftTableViewCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView;
@property (nonatomic, weak) UIView *separatorLine;
@property (nonatomic, weak) UIView *liner;

@end
@implementation leftTableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView{
    leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kleftTableViewCell];
    if (cell == nil) {
        cell = [[leftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kleftTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView {
    // 选中条
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedBackgroundView;
    UIView *liner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 90)];
    liner.backgroundColor = [UIColor lightGrayColor];
    [selectedBackgroundView addSubview:liner];
    self.liner = liner;
    
    // 分割线
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:separatorLine];
    self.separatorLine = separatorLine;
    

    [self layoutIfNeeded];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];

}


-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.separatorLine.backgroundColor = [UIColor grayColor];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.separatorLine.backgroundColor = [UIColor grayColor];
}

@end

//
@interface rightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) JHPersonModel *personModel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@end
@implementation rightTableViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.nameLabel.layer.borderWidth = 1.5;
    self.nameLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.nameLabel.layer.cornerRadius = 3;
    self.nameLabel.layer.masksToBounds = YES;
}

-(void)setPersonModel:(JHPersonModel *)personModel {
    _personModel = personModel;
    
    if ([personModel.name1 isEqualToString:@" "] || personModel.name1 == nil) {
        self.nameLabel.text = @"无备注信息";
    } else {
        self.nameLabel.text = personModel.name1;
    }
    [self.nameLabel sizeToFit];
    self.phoneNumberLabel.text = personModel.tel;
    NSLog(@"setPersonModel self.nameLabel.text = %@",self.nameLabel.text);
}

-(void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    CGSize nameSize = [self.nameLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.nameLabel.frame.size.height) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0]} context:nil].size;
    CGRect nameF = self.nameLabel.frame;
    nameF.size.width = nameSize.width + 10;
    nameF.size.height = nameSize.height + 4;
    self.nameLabel.frame = nameF;
}

@end



@interface JHContactViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (nonatomic,strong)  NSMutableArray *listContent;
@property (nonatomic, strong) JHAddressBook *addressBook;
@property (nonatomic, strong) JHPersonModel *personModel;
@property (nonatomic, strong) NSMutableArray *cellIDArr;
@end

@implementation JHContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor yellowColor];
    [self initCellID];
    [self initView];
    [self initData];
    
       _isRelate = YES;
}

-(void)initCellID{
    self.cellIDArr = [NSMutableArray new];
    [self.cellIDArr addObject:kleftTableViewCell];
    [self.cellIDArr addObject:krightTableViewCell];
}

-(void)initData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initSubData];
        [self initTitleList];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.rightTableView reloadData];
            [self.leftTableView reloadData];
        });
    });
}

-(void)initSubData {
    _addressBook = [JHAddressBook new];
    self.listContent = [_addressBook getAllPerson];
    if (self.listContent == nil) {
        UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数据为空或通讯录权限拒绝访问，请到系统开启" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alterview show];
    }
}
-(void)initTitleList{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    _sectionTitles =[NSMutableArray new];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]]; // 27
    NSMutableArray *existTitles = [NSMutableArray array];
    for (int i = 0; i<self.listContent.count; i++) {
        JHPersonModel *personModel = self.listContent[i][0];
        for (int j = 0; j<self.sectionTitles.count; j++) {
            if (personModel.sectionNumber == j) {
                [existTitles addObject:self.sectionTitles[j]];
            }
        }
    }
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles = existTitles;
}

-(void)initView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self leftTableView];
    [self rightTableView];
}

#pragma mark - data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.leftTableView) {
        return self.sectionTitles.count;
    } else {
        return self.listContent.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 1;
    } else {
        return [[self.listContent objectAtIndex:(section)] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kleftTableViewCell];
        
        if (cell == nil) {
            cell = [[leftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kleftTableViewCell];
        }

        NSString *sectionStr=[self.sectionTitles objectAtIndex:(indexPath.section)];
        cell.textLabel.text = sectionStr;
        return cell;
    } else {
        rightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:krightTableViewCell];
        NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
        _personModel = (JHPersonModel *)[sectionArr objectAtIndex:indexPath.row];
        cell.personModel = _personModel;
        return cell;
    }
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        NSArray *sectionArr = self.listContent[indexPath.section];
        self.personModel = (JHPersonModel *)sectionArr[indexPath.row];
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:YES];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"拨打" message:self.personModel.tel preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIApplication *app = [UIApplication sharedApplication];


            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.personModel.tel]];
            if ([app canOpenURL:url]) {
                [app openURL:url options:@{} completionHandler:nil];
            }
        }]];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 90;
    } else {
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 0;
    } else {
            //重要,或者0.01
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = RGB(235, 255, 238);
        UILabel *lable = [[UILabel alloc]initWithFrame:view.bounds];
        NSString *sectionStr = self.sectionTitles[section];
        
        lable.text = sectionStr;
        [view addSubview:lable];
        
        return view;
        
    } else {
        return nil;
    }
}

#pragma mark - 懒加载
- (UITableView *)leftTableView {
    if (nil == _leftTableView){
    
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [self.view addSubview:_leftTableView];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (nil == _rightTableView){
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 100, self.view.frame.size.height)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([rightTableViewCell class]) bundle:nil] forCellReuseIdentifier:krightTableViewCell];
        [self.view addSubview:_rightTableView];
    }
    return _rightTableView;
}

-(NSMutableArray *)listContent
{
    if (_listContent == nil) {
        _listContent = [NSMutableArray new];
    }
    return _listContent;
}



@end
