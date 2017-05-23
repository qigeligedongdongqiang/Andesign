//
//  DesignViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "DesignViewController.h"
#import "DesignTableViewCell.h"
#import "DesignModel.h"
#import "MyDesignAPI.h"
#import "DetailViewController.h"

@interface DesignViewController ()

@property (nonatomic, strong) NSMutableArray *designArr;
@property (nonatomic, assign) BOOL isFirstEnter;

@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"DESIGN";
    self.tableView.showsVerticalScrollIndicator = NO;
    self.isFirstEnter = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    if (_isFirstEnter) {
        self.isFirstEnter = NO;
        [[CustomLoading sharedManager] showLoadingTo:nil];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MPWeakSelf(self)
        [[MyDesignAPI shareManager] getDesigns:^(NSArray *modelArr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MPStrongSelf(self)
                [strongself.tableView.mj_header endRefreshing];
                [[CustomLoading sharedManager] hideLoadingFor:nil];
                strongself.designArr = modelArr.mutableCopy;
                [strongself.tableView reloadData];
            });
        }];
    });
}

- (void)refreshData {
    [self.designArr removeAllObjects];
    [self loadData];
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.designArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DesignTableViewCell class])];
    DesignModel *designModel;
    if (indexPath.row < self.designArr.count) {
        designModel = self.designArr[indexPath.row];
    }
    cell.designModel = designModel;
    return cell;
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    UIImageView *maseView = [[UIImageView alloc] initWithImage:cell.designImgView.image];
    maseView.frame = rect;
    maseView.layer.masksToBounds = true;
    maseView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:maseView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [maseView removeFromSuperview];
    });
    [self enterDesignDetailViewWith:self.designArr[indexPath.row] AndStartFrame:rect];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:true AtIsAnimation:true];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:false AtIsAnimation:true];
}

#pragma mark - enterDetail
- (void)enterDesignDetailViewWith:(DesignModel *)designModel AndStartFrame:(CGRect)startFrame{
    dispatch_async(dispatch_get_main_queue(), ^{
        DetailViewController *detailVC = [[DetailViewController alloc] initWithModel:designModel];
        detailVC.startFrame = startFrame;
        [self presentViewController:detailVC animated:YES completion:nil];
    });
}

#pragma mark - lazyLoad
- (NSMutableArray *)designArr {
    if (!_designArr) {
        _designArr = [NSMutableArray array];
    }
    return _designArr;
}

#pragma mark - setConfig
- (BOOL)isCellNib {
    return YES;
}

- (NSArray *)cellReuseId {
    return @[NSStringFromClass([DesignTableViewCell class])];
}

- (BOOL)needRefresh {
    return YES;
}

- (NSMutableAttributedString *)setTitle {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"DESIGN"];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont customFontOfSize:20 withName:kTitleFontName withExtension:@"otf"] range:NSMakeRange(0, 6)];
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
