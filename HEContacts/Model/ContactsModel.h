//
//  ContactsModel.h
//  HEContacts
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject
/*** 联系人头像***/
@property (nonatomic,copy) NSString *headerImagesName;
/*** 联系人名字***/
@property (nonatomic,copy) NSString *contactsName;

- (instancetype)initWithHeaderImagesName:(NSString *)headerImagesName contactsName:(NSString *)contactsName;
@end
