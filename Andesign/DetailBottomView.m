//
//  DetailBottomView.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "DetailBottomView.h"
#import "DesignModel.h"
#import "PhotographyModel.h"

typedef enum {
    PageTypeDesign,
    PageTypePhotography
}PageType;

@interface DetailBottomView ()

@property (nonatomic, assign) PageType pageType;
@property (nonatomic, strong) DesignModel *designModel;
@property (nonatomic, strong) PhotographyModel *photographyModel;

@property (nonatomic, strong) UIImageView *backgroungImgV;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DetailBottomView

- (instancetype)initWithResources:(id)resources {
    if (self = [super init]) {
        if ([resources isKindOfClass:[DesignModel class]]) {
            _designModel = resources;
            _pageType = PageTypeDesign;
        } else if ([resources isKindOfClass:[PhotographyModel class]]) {
            _photographyModel = resources;
            _pageType = PageTypePhotography;
        }
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews {
    self.clipsToBounds = YES;
    
    self.backgroungImgV = [[UIImageView alloc] init];
    self.backgroungImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroungImgV.clipsToBounds = YES;
    [self addSubview:self.backgroungImgV];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    [self.backgroungImgV addSubview:self.effectView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    self.summaryLabel = [[UILabel alloc] init];
    self.summaryLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.summaryLabel];
    
    self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.detailBtn.clipsToBounds = YES;
    [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.detailBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.detailBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    self.detailBtn.titleLabel.numberOfLines = 0;
    [self addSubview:self.detailBtn];
    
    switch (_pageType) {
        case PageTypeDesign:
            self.backgroungImgV.image = [UIImage imageWithData:_designModel.mainImg];
            self.titleLabel.text = _designModel.title;
            self.summaryLabel.text = _designModel.summary;
            [self.detailBtn setTitle:_designModel.detailText forState:UIControlStateNormal];
            break;
            
        case PageTypePhotography:
            self.backgroungImgV.image = [UIImage imageWithData:_photographyModel.mainImg];
            self.titleLabel.text = _photographyModel.title;
            self.summaryLabel.text = _photographyModel.summary;
            [self.detailBtn setTitle:_photographyModel.detailText forState:UIControlStateNormal];
            break;
    }
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.line];
    
    self.buttonType = ExpandButtonTypeClose;
    self.expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.expandBtn setImage:[UIImage imageNamed:@"action_up"] forState:UIControlStateNormal];
    [self.expandBtn addTarget:self action:@selector(expandBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.expandBtn];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_backgroungImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(_backgroungImgV);
    }];
    
    [_expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(10);
        make.width.height.mas_equalTo(44);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(_expandBtn.mas_left).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(_expandBtn.mas_left).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.height.mas_equalTo(0.5);
    }];
    
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(10);
        make.left.equalTo(self).offset(12);
        make.right.equalTo(self).offset(-12);
        make.bottom.equalTo(self).offset(-10);
    }];
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self refreshFrame];
}

- (void)refreshFrame {
    _backgroungImgV.frame = self.bounds;
    _effectView.frame = self.bounds;
    NSLog(@"%@",NSStringFromCGRect(_backgroungImgV.frame));
}

- (void)expandBtnAction {
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickExpandBtnOfType:)]) {
        [self.delegate bottomView:self didClickExpandBtnOfType:self.buttonType];
    }
    if (self.buttonType == ExpandButtonTypeClose) {
        [UIView animateWithDuration:0.3 animations:^{
            self.expandBtn.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            self.buttonType = ExpandButtonTypeOpen;
            self.detailBtn.frame = CGRectMake(12, CGRectGetMaxY(self.line.frame)+10, self.bounds.size.width-24, 50);
        }];
    } else if (self.buttonType == ExpandButtonTypeOpen) {
        [UIView animateWithDuration:0.3 animations:^{
            self.expandBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.buttonType = ExpandButtonTypeClose;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
