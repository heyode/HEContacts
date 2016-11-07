//
//  ContactsModel.m
//  HEContacts
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel

- (instancetype)initWithHeaderImagesName:(NSString *)headerImagesName contactsName:(NSString *)contactsName
{
    self = [[[self class] alloc] init];
    self.headerImagesName = headerImagesName;
    self.contactsName = contactsName;
    return self;
}
@end
