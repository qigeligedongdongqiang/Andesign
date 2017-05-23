//
//  MyDesignViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyDesignViewController.h"
#import "MyDesignTableViewCell.h"
#import "DesignModel.h"
#import "EditViewController.h"

#import "MyDesignAPI.h"
#import "ImageAPI.h"

@interface MyDesignViewController ()

@property (nonatomic, strong) NSMutableArray *designArr;
@property (nonatomic, assign) BOOL isFirstEnter;

@end

@implementation MyDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DESIGN";
    self.isFirstEnter = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
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
            MPStrongSelf(self)
            dispatch_async(dispatch_get_main_queue(), ^{
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

- (void)deleteDesignWithIndex:(NSInteger)index {
    DesignModel *designModel = self.designArr[index];
    MPWeakSelf(self)
    [[MyDesignAPI shareManager] deleteDesignWithDesignId:designModel.designId isSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [[ImageAPI shareManager] deleteDesignImagesWithRelateId:designModel.designId IsSuccess:^(BOOL isSuccess) {
                MPStrongSelf(self)
                if (isSuccess) {
                    [strongself.designArr removeObjectAtIndex:index];
                    [strongself.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                } else {
                    [MBProgressHUD showAutoMessage:@"删除失败，请重试" ToView:nil];
                }
            }];
        } else {
            [MBProgressHUD showAutoMessage:@"删除失败，请重试" ToView:nil];
        }
    }];
    
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.designArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyDesignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyDesignTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DesignModel *designModel;
    if (indexPath.row<self.designArr.count) {
        designModel = self.designArr[indexPath
                                   .row];
    }
    cell.designModel = designModel;
    return cell;
}

#pragma mark - delegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DesignModel *designModel;
    if (indexPath.row<self.designArr.count) {
        designModel = self.designArr[indexPath.row];
    }
    EditViewController *editVC = [[EditViewController alloc] initDesignWithDesignModel:designModel];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"  删除  ";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteDesignWithIndex:indexPath.row];
    }
}

#pragma mark - setConfig
- (UIImage *)set_leftBarButtonItemWithImage {
    return [UIImage imageNamed:@"back_icon"];
}

- (UIButton *)set_rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    return button;
}

- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)right_button_event:(UIButton *)sender {
    EditViewController *editVC = [[EditViewController alloc] initDesignWithDesignModel:nil];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (BOOL)isCellNib {
    return YES;
}

- (NSArray *)cellReuseId {
    return @[NSStringFromClass([MyDesignTableViewCell class])];
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
