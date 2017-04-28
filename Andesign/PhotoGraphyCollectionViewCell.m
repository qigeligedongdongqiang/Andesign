//
//  PhotoGraphyCollectionViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/31.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "PhotoGraphyCollectionViewCell.h"
#import "PhotographyModel.h"

@implementation PhotoGraphyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPhotographyModel:(PhotographyModel *)photographyModel {
    _photographyModel = photographyModel;
    
    self.photoImgView.image = [UIImage imageWithData:photographyModel.mainImg];
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

@end
