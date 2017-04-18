//
//  EditImageCollectionViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "EditImageCollectionViewCell.h"

@implementation EditImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteButtonAction {
    if (self.deleteAction) {
        self.deleteAction();
    }
}

@end
