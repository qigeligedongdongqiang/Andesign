//
//  AboutHeaderView.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "AboutHeaderView.h"
#import "MineModel.h"

@implementation AboutHeaderView

+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)layoutSubviews {
    self.iconImgView.layer.cornerRadius = 40;
    self.iconImgView.layer.masksToBounds = YES;
    
    [self.iconButton addTarget:self action:@selector(iconButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)iconButtonAction {
    if (self.buttonAction) {
        self.buttonAction();
    }
}

- (void)setMineModel:(MineModel *)mineModel {
    _mineModel = mineModel;
    
    self.iconImgView.image = [UIImage imageWithData:mineModel.iconImg];
    self.nickNameLabel.text = mineModel.nickName;
}

@end
