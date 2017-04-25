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
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longCliped:)];
    longGes.minimumPressDuration = 1;
    [self.contentView addGestureRecognizer:longGes];
}

- (void)setDesignModel:(DesignModel *)designModel {
    _designModel = designModel;
    
    self.titleLabel.text = designModel.title;
    self.summaryLabel.text = designModel.summary;
    self.designImgView.image = [UIImage imageWithData:designModel.mainImg];
}

- (void)longCliped:(UILongPressGestureRecognizer *)longGes {
    if (longGes.state == UIGestureRecognizerStateBegan) {
        self.renderView.hidden = YES;
    } else if (longGes.state == UIGestureRecognizerStateEnded) {
        self.renderView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
