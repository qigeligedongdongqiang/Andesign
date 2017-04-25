//
//  MyPhotographyTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotographyModel;

@interface MyPhotographyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (nonatomic, strong) PhotographyModel *photographyModel;

@end
