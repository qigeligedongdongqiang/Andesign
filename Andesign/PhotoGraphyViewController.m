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

@interface PhotoGraphyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *photoArr;

@end

@implementation PhotoGraphyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"PHOTOGRAPHY";
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoGraphyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PhotoGraphyCollectionViewCell class])];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadData {
    for (NSInteger i = 0; i < 50; i++) {
        [self.photoArr addObject:@1];
    }
    [self.collectionView reloadData];
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
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - waterFlowDelegate
//- (NSInteger)columnCountOfWaterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout {
//    return 2;
//}

- (CGFloat)waterFlowCollectionViewLayout:(WaterFlowCollectionViewLayout *)layout heightForItemAtIndexPath:(NSInteger)index ItemWith:(CGFloat)width {
    return arc4random_uniform(150)+50;
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
    }
    return _collectionView;
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
