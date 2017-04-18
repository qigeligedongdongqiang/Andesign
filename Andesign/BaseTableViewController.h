//
//  BaseTableViewController.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isCellNib;
@property (nonatomic, copy) NSArray *cellReuseId;

@property (nonatomic, assign) BOOL needRefresh;

@property (nonatomic, assign) BOOL isDividePage;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;

- (void)loadData;
- (void)refreshData;
- (void)loadMoreData;

@end
