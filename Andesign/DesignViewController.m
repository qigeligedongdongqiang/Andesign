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

@interface DesignViewController ()

@property (nonatomic, strong) NSMutableArray *designArr;

@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"DESIGN";
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MPWeakSelf(self)
        [[MyDesignAPI shareManager] getDesigns:^(NSArray *modelArr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                MPStrongSelf(self)
                [strongself.tableView.mj_header endRefreshing];
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
