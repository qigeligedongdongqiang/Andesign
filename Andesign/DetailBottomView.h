//
//  DetailBottomView.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ExpandButtonType) {
    ExpandButtonTypeOpen = 0,
    ExpandButtonTypeClose
};

@class DetailBottomView;

@protocol DetailBottomViewDelegate <NSObject>

@optional
- (void)bottomView:(DetailBottomView *)bottomView didClickExpandBtnOfType:(ExpandButtonType)buttonType;

@end


@interface DetailBottomView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *detailBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *expandBtn;
@property (nonatomic, assign) ExpandButtonType buttonType;
@property (nonatomic, weak) id<DetailBottomViewDelegate> delegate;

- (instancetype)initWithResources:(id)resources;

@end
