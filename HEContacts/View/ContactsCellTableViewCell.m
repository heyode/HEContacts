//
//  ContactsCellTableViewCell.m
//  HEContacts
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 heyode. All rights reserved.
//

#import "ContactsCellTableViewCell.h"
#import "ContactsModel.h"

@interface ContactsCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *contactsNameLab;


@end

@implementation ContactsCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ContactsModel *)model
{
    _model = model;
    self.headerImgView.image = [UIImage imageNamed:model.headerImagesName];
    
    self.contactsNameLab.text = model.contactsName;
}

@end
