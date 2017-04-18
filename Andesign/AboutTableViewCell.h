//
//  AboutTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cellSelectBlock)();

@interface AboutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@property (nonatomic, copy) cellSelectBlock cellSelectAction;

@end
