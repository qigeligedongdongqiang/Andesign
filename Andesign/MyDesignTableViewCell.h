//
//  MyDesignTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignModel;

@interface MyDesignTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (nonatomic, strong) DesignModel *designModel;

@end
