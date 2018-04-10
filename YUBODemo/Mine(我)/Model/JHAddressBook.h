//
//  JHAddressBook.h
//  YUBODemo
//
//  Created by huguan-mac02 on 2018/1/16.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

@interface JHAddressBook : NSObject
{
     NSArray *_addressArr;
     NSMutableArray *_persons;
     NSMutableArray *_listContent;
     NSMutableArray *_list2Content;
}

@property (nonatomic,strong) NSMutableArray *perArr;
@property (nonatomic,strong) UILocalizedIndexedCollation *localCollation;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

-(NSMutableArray*)getAllPerson;
@end
