//
//  AboutTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cellButton addTarget:self action:@selector(cellButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cellButtonAction {
    if (self.cellSelectAction) {
        self.cellSelectAction();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
