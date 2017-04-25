//
//  PhotoGraphyViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/31.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "PhotoGraphyViewController.h"
#import "WaterFlowCollectionViewLayout.h"
#import "PhotoGraphyCollectionViewCell.h"
#import "PhotographyModel.h"
#import "MyPhotoAPI.h"

#define kColumnCount 2
#define kColumnMargin 10
#define kRowMargin 10
#define kEdgeInset 10

@interface PhotoGraphyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photoArr;

@end

@implementation PhotoGraphyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"PHOTOGRAPHY";
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoGraphyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PhotoGraphyCollectionViewCell class])];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MPWeakSelf(self)
        [[MyPhotoAPI shareManager] getPhotos:^(NSArray *modelArr) {
            dispatch_async(dispatch_get_main_queue(), ^{                
                MPStrongSelf(self)
                [strongself.collectionView.mj_header endRefreshing];
                strongself.photoArr = modelArr.mutableCopy;
                [strongself.collectionView reloadData];
            });
        }];
    });
}

- (void)refreshData {
    [self.photoArr removeAllObjects];
    [self loadData];
}

#pragma mark - dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoGraphyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoGraphyCollectionViewCell class]) forIndexPath:indexPath];
    PhotographyModel *photographyModel;
    if (indexPath.row<self.photoArr.count) {
        photographyModel = self.photoArr[indexPath.row];
    }
    cell.photographyModel = photographyModel;
    return cell;
}

#pragma mark - waterFlowDelegate
- (NSInteger)columnCountOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout {
    return kColumnCount;
}

- (CGFloat)columnMarginOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout {
    return kColumnMargin;
}

- (CGFloat)rowMarginOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout {
    return kRowMargin;
}

- (UIEdgeInsets)edgeInsetsOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout {
    return UIEdgeInsetsMake(kEdgeInset,kEdgeInset,kEdgeInset,kEdgeInset);
}

- (CGFloat)waterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout heightForItemAtIndexPath:(NSInteger)index ItemWith:(CGFloat)width {
    PhotographyModel *model;
    if (index < self.photoArr.count) {
        model = self.photoArr[index];
    }
    UIImage *mainImg = [UIImage imageWithData:model.mainImg];
    CGFloat rowWidth = (self.collectionView.frame.size.width - kEdgeInset*2 - (kColumnCount-1)*kColumnMargin)/kColumnCount;
    CGFloat rowHeight = mainImg.size.height/mainImg.size.width*rowWidth;
    return rowHeight;
}

#pragma mark - lazyLoad
- (NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WaterFlowCollectionViewLayout *layout = [[WaterFlowCollectionViewLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = HEXCOLOR(0xF0F0F0);
        _collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self refreshData];
        }];
    }
    return _collectionView;
}

#pragma mark - setConfig
- (NSMutableAttributedString *)setTitle {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"PHOTOGRAPHY"];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont customFontOfSize:20 withName:kTitleFontName withExtension:@"otf"] range:NSMakeRange(0, 11)];
    return attributeStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
