//
//  EditImageCollectionViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock)();

@interface EditImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImgView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, copy) DeleteBlock deleteAction;

@end
