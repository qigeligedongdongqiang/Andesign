//
//  WaterFlowCollectionViewLayout.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/31.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowCollectionViewLayout;

@protocol WaterFlowCollectionViewLayoutDelegate <NSObject>

@required
//cell高度
- (CGFloat)waterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout heightForItemAtIndexPath:(NSInteger)index ItemWith:(CGFloat)width;

@optional
- (NSInteger)columnCountOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout;
- (CGFloat)columnMarginOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout;
- (CGFloat)rowMarginOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout;
- (UIEdgeInsets)edgeInsetsOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout;

@end

@interface WaterFlowCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFlowCollectionViewLayoutDelegate> delegate;

@end
