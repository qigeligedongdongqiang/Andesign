//
//  BaseTableViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomConfig];
    [self.view addSubview:self.tableView];
}

#pragma mark - setUp
- (void)setCustomConfig {
    self.currentPage = 1;
    
    if (self.isCellNib) {
        if (self.cellReuseId.count > 0) {
            for (NSString *cellId in self.cellReuseId) {
                UINib *nib = [UINib nibWithNibName:cellId bundle:nil];
                [self.tableView registerNib:nib forCellReuseIdentifier:cellId];
            }
        }
    } else {
        if (self.cellReuseId.count > 0) {
            for (NSString *cellId in self.cellReuseId) {
                [self.tableView registerClass:NSClassFromString(cellId) forCellReuseIdentifier:cellId];
            }
        }
    }
}

#pragma mark - dataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - loadData
- (void)loadData {
    
}

- (void)refreshData {
    
}

- (void)loadMoreData {
    [self loadData];
}

#pragma mark - lazyLoad
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HEXCOLOR(0xf0f0f0);
        
        MPWeakSelf(self)
        if (self.needRefresh) {
            _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                [weakself refreshData];
            }];
        }
        
        if (self.isDividePage) {
            _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
                [weakself loadMoreData];
            }];
        }
    }
    return _tableView;
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
