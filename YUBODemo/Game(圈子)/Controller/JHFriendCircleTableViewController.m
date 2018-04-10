//
//  JHFriendCircleTableViewController.m
//  YUBODemo
//
//  Created by cjh on 2018/3/16.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "JHFriendCircleTableViewController.h"
#import <Foundation/Foundation.h>
#import "UITableViewCell+Func.h"
#import "JHContentCell.h"

static NSString *cellID = @"cellID";

@interface JHFriendCircleTableViewController ()
@property (nonatomic, assign) CGFloat contHeight;
@end

@implementation JHFriendCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellID = nil;
    
    switch (indexPath.row)
    {
        case 0:
            cellID=@"CellID";
            break;
        case 1:
            cellID=@"headCell";
            break;
        case 2:
            cellID=@"commentsCell";
            break;
        
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        //    self.cellH=80;
        //    cell.userInteractionEnabled=NO;

    
    [cell setCellInfo];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0)
        {
        return 170;
        }
    else if(indexPath.row==1)
        {
            //        ZanView * zan = [ZanView new];
            //        CGRect rect;
            //        rect=zan.frame;
            //        return rect.size.height;
        return 85;
        }
    else
        return 100;
    

}

@end
