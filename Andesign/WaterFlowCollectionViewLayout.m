//
//  WaterFlowCollectionViewLayout.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/31.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "WaterFlowCollectionViewLayout.h"
//默认列数
static const NSInteger waterDefaultColumnCount = 3;
//默认每一列间距
static const CGFloat waterDefaultColumnMargin = 10;
//默认每一行间距
static const CGFloat waterDefaultRowMargin = 10;
//默认边缘间距
static const UIEdgeInsets waterDefaultEdgeInsets = {10,10,10,10};

@interface WaterFlowCollectionViewLayout ()

//私有属性
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) CGFloat columnMargin;
@property (nonatomic, assign) CGFloat rowMargin;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

//记录每列的高度
@property (nonatomic, strong) NSMutableArray *columnHeightsArr;
//记录所有列最大的高度
@property (nonatomic, assign) CGFloat maxColumnHeight;
//每个item的attribute
@property (nonatomic, strong) NSMutableArray *attributesArr;

@end

@implementation WaterFlowCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self caculateCellFrameAndPlace];
}

- (void)caculateCellFrameAndPlace {
    _maxColumnHeight = 0;
    [self.columnHeightsArr removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        [self.columnHeightsArr addObject:@(self.edgeInsets.top)];
    }
    
    [self.attributesArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArr addObject:attributes];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    CGFloat cellWidth = (collectionWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat cellHeight = [self.delegate waterFlowCollectionViewLayout:self heightForItemAtIndexPath:indexPath.item ItemWith:cellWidth];
    
    //找到高度最短一列
    NSInteger minHeightColumnIndex = 0;
    CGFloat minCoulmnHeight = [self.columnHeightsArr[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        CGFloat columnHeight = [self.columnHeightsArr[i] doubleValue];
        if (columnHeight < minCoulmnHeight) {
            minCoulmnHeight = columnHeight;
            minHeightColumnIndex = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + minHeightColumnIndex * (cellWidth + self.columnMargin);
    CGFloat y = minCoulmnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attribute.frame = CGRectMake(x, y, cellWidth, cellHeight);
    
    //更新记录的高度
    self.columnHeightsArr[minHeightColumnIndex] = @(CGRectGetMaxY(attribute.frame));
    CGFloat columnHeight = [self.columnHeightsArr[minHeightColumnIndex] doubleValue];
    if (_maxColumnHeight < columnHeight) {
        _maxColumnHeight = columnHeight;
    }
    
    return attribute;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.maxColumnHeight + self.edgeInsets.bottom);
}

#pragma mark - lazyLoad
- (NSMutableArray *)columnHeightsArr {
    if (!_columnHeightsArr) {
        _columnHeightsArr = [NSMutableArray array];
    }
    return _columnHeightsArr;
}

- (NSMutableArray *)attributesArr {
    if (!_attributesArr) {
        _attributesArr = [NSMutableArray array];
    }
    return _attributesArr;
}

#pragma mark - getters
- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountOfWaterFlowCollectionViewLayout:)]) {
        return [self.delegate columnCountOfWaterFlowCollectionViewLayout:self];
    }
    return waterDefaultColumnCount;
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginOfWaterFlowCollectionViewLayout:)]) {
        return [self.delegate columnMarginOfWaterFlowCollectionViewLayout:self];
    }
    return waterDefaultColumnMargin;
}

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginOfWaterFlowCollectionViewLayout:)]) {
        return [self.delegate rowMarginOfWaterFlowCollectionViewLayout:self];
    }
    return waterDefaultRowMargin;
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsOfWaterFlowCollectionViewLayout:)]) {
        return [self.delegate edgeInsetsOfWaterFlowCollectionViewLayout:self];
    }
    return waterDefaultEdgeInsets;
}


@end
