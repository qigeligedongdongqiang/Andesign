//
//  MyPhotographyViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyPhotographyViewController.h"
#import "MyPhotographyTableViewCell.h"
#import "EditViewController.h"
#import "PhotographyModel.h"

#import "MyPhotoAPI.h"
#import "ImageAPI.h"

@interface MyPhotographyViewController ()

@property (nonatomic, strong) NSMutableArray *photographyArr;

@end

@implementation MyPhotographyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PHOTOGRAPHY";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        MPWeakSelf(self)
        [[MyPhotoAPI shareManager] getPhotos:^(NSArray *modelArr) {
            MPStrongSelf(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongself.tableView.mj_header endRefreshing];
                strongself.photographyArr = modelArr.mutableCopy;
                [strongself.tableView reloadData];
            });
        }];
    });
}

- (void)refreshData {
    [self.photographyArr removeAllObjects];
    [self loadData];
}

- (void)deletePhotoWithIndex:(NSInteger)index {
    PhotographyModel *photographyModel = self.photographyArr[index];
    MPWeakSelf(self)
    [[MyPhotoAPI shareManager] deletePhotoWithPhotographyId:photographyModel.photographyId isSuccess:^(BOOL isSuccess) {
        if (isSuccess) {
            [[ImageAPI shareManager] deletePhotographyImagesWithRelateId:photographyModel.photographyId IsSuccess:^(BOOL isSuccess) {
                MPStrongSelf(self)
                if (isSuccess) {
                    [strongself.photographyArr removeObjectAtIndex:index];
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
    return self.photographyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPhotographyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyPhotographyTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PhotographyModel *photographyModel;
    if (indexPath.row<self.photographyArr.count) {
        photographyModel = self.photographyArr[indexPath
                                     .row];
    }
    cell.photographyModel = photographyModel;
    return cell;
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotographyModel *photographyModel;
    if (indexPath.row<self.photographyArr.count) {
        photographyModel = self.photographyArr[indexPath.row];
    }
    EditViewController *editVC = [[EditViewController alloc] initPhotographyWithphotographyModel:photographyModel];
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
        [self deletePhotoWithIndex:indexPath.row];
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
    EditViewController *editVC = [[EditViewController alloc] initPhotographyWithphotographyModel:nil];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (BOOL)isCellNib {
    return YES;
}

- (NSArray *)cellReuseId {
    return @[NSStringFromClass([MyPhotographyTableViewCell class])];
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
