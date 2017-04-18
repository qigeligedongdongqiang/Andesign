//
//  EditImageTableViewCell.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddImgBlock)();
typedef void(^DeleteImgBlock)(NSInteger index);

@interface EditImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, copy) AddImgBlock addImgAction;
@property (nonatomic, copy) DeleteImgBlock deleteImgAction;

@property (nonatomic, assign) NSInteger maxImageNumber;

@end
