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

@interface MyDesignViewController ()

@property (nonatomic, strong) NSArray *designArr;

@end

@implementation MyDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DESIGN";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [self loadData];
}

#pragma mark - loadData
- (void)loadData {
    MPWeakSelf(self)
    [[MyDesignAPI shareManager] getDesigns:^(NSArray *modelArr) {
        MPStrongSelf(self)
        strongself.designArr = modelArr;
        [strongself.tableView reloadData];
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
