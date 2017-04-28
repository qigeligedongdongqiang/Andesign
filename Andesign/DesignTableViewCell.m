//
//  DesignTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "DesignTableViewCell.h"
#import "DesignModel.h"

@implementation DesignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setDesignModel:(DesignModel *)designModel {
    _designModel = designModel;
    
    self.titleLabel.text = designModel.title;
    self.summaryLabel.text = designModel.summary;
    self.designImgView.image = [UIImage imageWithData:designModel.mainImg];
}

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations {
    if (isHighlightRow) {
        
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                self.renderView.alpha = 0.0f;
            } completion:^(BOOL finished) {}];
        } else {
            self.renderView.alpha = 0.0f;
        }
        
    } else {
        
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                self.renderView.alpha = 1.0f;
            } completion:^(BOOL finished) {}];
        } else {
            self.renderView.alpha = 1.0f;
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
