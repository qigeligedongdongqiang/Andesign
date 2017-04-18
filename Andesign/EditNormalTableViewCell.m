//
//  EditNormalTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "EditNormalTableViewCell.h"

@implementation EditNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewScrollPositionNone;
    // Initialization code
    [self.inputTextField setValue:HEXCOLOR(0xCCCCCC) forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
