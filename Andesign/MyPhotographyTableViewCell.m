//
//  MyPhotographyTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyPhotographyTableViewCell.h"
#import "PhotographyModel.h"

@implementation MyPhotographyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPhotographyModel:(PhotographyModel *)photographyModel {
    _photographyModel = photographyModel;
    
    self.iconImageView.image = [UIImage imageWithData:photographyModel.mainImg];
    self.titleLabel.text = photographyModel.title;
    self.summaryLabel.text = photographyModel.summary;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
