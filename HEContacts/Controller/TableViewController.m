//
//  TableViewController.m
//  HEContacts
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 heyode. All rights reserved.
//
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define TITLE_COLOR  RGBA(41, 191, 50, 1);


#import "TableViewController.h"
#import "ContactsModel.h"
#import "ContactsCellTableViewCell.h"

NSString * const cellId = @"ContactsCellTableViewCell";
/*** 标题高度***/
CGFloat const titleViewHeight = 20;
/*** cell高度***/
CGFloat const rowHeight = 65;

@interface TableViewController ()
/*** 原始通讯录数据***/
@property (nonatomic,strong) NSMutableArray <ContactsModel *> *contactsArr;
/*** 索引标题数组***/
@property (nonatomic,strong) NSMutableArray *indexArray;
/*** 每组要展示的模型数组***/
@property (nonatomic,strong) NSMutableArray *groupModelArr;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self initContactsArr];
    [self sortWithContactsArr];
}


#pragma mark - 懒加载

- (NSMutableArray *)contactsArr
{
    if(!_contactsArr){
        _contactsArr = [[NSMutableArray alloc] init];
    }
    return _contactsArr;
}


#pragma mark - 设置tableView相关属性

- (void)setUpTableView
{
    self.title = @"通讯录";
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactsCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    // 索引的颜色
    self.tableView.sectionIndexColor  = TITLE_COLOR;
}

#pragma mark - 初始化原始数据

- (void)initContactsArr
{
    NSArray *names = @[@"小张",@"1王二",@"小程",@"李四",@"1张三",@"二傻",@"二狗",@"还是他",@"萌萌哒",@"a哈哈",@"五五",@"SB",@"傻傻",@"三狗",@"囧囧",@"喝喝哒",@"wa哈哈"];
    for (int i = 0; i < names.count; i++) {
        ContactsModel *model = [[ContactsModel alloc] initWithHeaderImagesName:[NSString stringWithFormat:@"img%i",i] contactsName:names[i]];
        [self.contactsArr addObject:model];
    }
}

#pragma mark - 处理原始数据，排序
/***ContactsArr排序后， 给模型数组和索引id的数组赋值***/
- (void)sortWithContactsArr
{
    NSDictionary *dataSource = [self sortListWhitSourceArray:self.contactsArr];
    self.indexArray = dataSource[@"index"];
    self.groupModelArr = dataSource[@"sortList"];
}

/*** 对给定的字段按首字母排序***/
- (NSDictionary *)sortListWhitSourceArray:(NSArray *)orginArr
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
 
    // sectionTitles里面是A-Z的字母
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    
    // 模型数组
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc] init];
    
    for (NSUInteger index = 0; index < numberOfSections; index ++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    
    // 将模型插入到数组对应的索引上
    for (ContactsModel *friModel in orginArr) {
        // 指定对象的指定属性，首字母是第多少个索引：如“小张”,首字母是“X” ，所以返回23
        NSUInteger sectionIndex = [collation sectionForObject:friModel collationStringSelector:@selector(contactsName)];
        [newSectionArray[sectionIndex] addObject:friModel];
    }
    
    //对每组里面的联系人进行排序
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(contactsName)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    NSMutableArray *indexArr = [NSMutableArray new];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {// 找出空数组
            [temp addObject:arr];
        } else {// 剩下的标题选出了即是联系人索引的数组
            [indexArr addObject:[collation sectionTitles][idx]];
        }
    }];
    
    // 删除空数组
    [newSectionArray removeObjectsInArray:temp];
    
    // index是索引数组（首写字母数组），sorlist是排完序的模型数组
    return @{@"index":indexArr,@"sortList":newSectionArray};
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return titleViewHeight;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groupModelArr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    label.text = [NSString stringWithFormat:@"   %@",self.indexArray[section]];
    label.textColor = TITLE_COLOR;
    label.backgroundColor = RGBA(230, 230, 230, 0.8);
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.groupModelArr[section];
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    ContactsModel * model =  self.groupModelArr[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
        if (self.indexArray.count>0) {
            return self.indexArray;
        }else{
            return nil;
        }
    
}



@end
