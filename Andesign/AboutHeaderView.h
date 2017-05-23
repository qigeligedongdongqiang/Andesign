//
//  AboutHeaderView.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterAnimationView.h"

@class MineModel;

typedef void(^IconButtonBlock)();

@interface AboutHeaderView : WaterAnimationView

+ (instancetype)viewFromXib;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@property (nonatomic, copy) IconButtonBlock buttonAction;

@property (nonatomic, strong) MineModel *mineModel;

@end
