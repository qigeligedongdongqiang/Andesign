//
//  EditTextViewTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/18.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYTextView;

@interface EditTextViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) YYTextView *detailTextView;

@end
