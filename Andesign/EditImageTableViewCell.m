//
//  EditImageTableViewCell.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "EditImageTableViewCell.h"
#import "EditImageCollectionViewCell.h"
#import "ImageModel.h"

#define kColumnNum 3
#define kMargin 10

@interface EditImageTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation EditImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewScrollPositionNone;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EditImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([EditImageCollectionViewCell class])];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;

}

#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = self.imagesArray.count;
    //如果没有大于最大上传数 则显示增加图标
    if (num<self.maxImageNumber) {
        return num+ 1;
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EditImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EditImageCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.imagesArray.count) {
        cell.selectImgView.image = [UIImage imageWithData:[self.imagesArray[indexPath.row] img]];
        cell.deleteAction = ^() {
            if (self.deleteImgAction) {
                self.deleteImgAction(indexPath.row);
            }
        };
        cell.deleteButton.hidden = NO;
    } else {
        cell.selectImgView.image = [UIImage imageNamed:@"btn_addPicture_BgImage"];
        cell.deleteButton.hidden = YES;
    }
    return cell;
}

#pragma mark - layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidthHeight = (Main_Screen_Width - kMargin * (kColumnNum + 1))/kColumnNum;
    return CGSizeMake(cellWidthHeight, cellWidthHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, kMargin, 0, kMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}

#pragma mark - setter
- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    [self.collectionView reloadData];
}

#pragma mark - delegate 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.imagesArray.count) {//添加图片
        if (self.addImgAction) {
            self.addImgAction();
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
