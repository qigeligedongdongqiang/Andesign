//
//  MyDesignTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyDesignTableViewCell.h"
#import "DesignModel.h"

@implementation MyDesignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDesignModel:(DesignModel *)designModel {
    _designModel = designModel;
    
    self.iconImgView.image = [UIImage imageWithData:designModel.mainImg];
    self.titleLabel.text = designModel.title;
    self.summaryLabel.text = designModel.summary;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
