//
//  DesignTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignModel;

@interface DesignTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *designImgView;
@property (weak, nonatomic) IBOutlet UIView *renderView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (nonatomic, strong) DesignModel *designModel;

@end
