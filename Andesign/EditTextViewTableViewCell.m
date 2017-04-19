//
//  EditTextViewTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/18.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "EditTextViewTableViewCell.h"
#import "UIPlaceHolderTextView.h"

@implementation EditTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:self.titleLabel];
    
    self.detailTextView = [[UIPlaceHolderTextView alloc] init];
    self.detailTextView.font = [UIFont systemFontOfSize:14];
    self.detailTextView.textColor = [UIColor blackColor];
    self.detailTextView.placeholderColor = HEXCOLOR(0xCCCCCC);
    [self addSubview:self.detailTextView];
}

- (void)layoutSubviews {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12);
    }];
    [_detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.right.bottom.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
