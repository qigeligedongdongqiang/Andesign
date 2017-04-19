//
//  EditTextViewTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/18.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIPlaceHolderTextView;

@interface EditTextViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPlaceHolderTextView *detailTextView;

@end
