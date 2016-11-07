//
//  ContactsCellTableViewCell.h
//  HEContacts
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactsModel;
@interface ContactsCellTableViewCell : UITableViewCell
/*** 模型***/
@property (nonatomic,strong) ContactsModel *model;
@end
