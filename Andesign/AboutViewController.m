//
//  AboutViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "AboutViewController.h"
#import "AboutTableViewCell.h"
#import "AboutHeaderView.h"
#import "AboutAPI.h"
#import "MineModel.h"
#import "MyDesignViewController.h"

@interface AboutViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) MineModel *mineModel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",NSHomeDirectory());
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    [self loadData];
}

- (void)loadData {
    MPWeakSelf(self)
    [[AboutAPI shareManager] getUserInfo:^(MineModel *model) {
        MPStrongSelf(self)
        strongself.mineModel = model;
        [strongself addHeaderViewWithInfo:model];
    }];
}

#pragma mark - addHeaderView
- (void)addHeaderViewWithInfo:(MineModel *)model {
    AboutHeaderView *headerView = [AboutHeaderView viewFromXib];
    headerView.mineModel = model;
    headerView.frame = CGRectMake(0, 0, Main_Screen_Width, 200);
    MPWeakSelf(self)
    headerView.buttonAction = ^() {
        [weakself changeUserIcon];
    };
    headerView.nickNameLabel.delegate = self;
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - changeUserIcon
- (void)changeUserIcon {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cameraClick];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoClick];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [sheet addAction:action1];
    [sheet addAction:action2];
    [sheet addAction:action3];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)cameraClick {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    // 判断照相机是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){//判断权限
                NSString *errorStr = @"应用相机权限受限,请在设置中启用";
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:sure];
                [imagePicker presentViewController:alert animated:YES completion:nil];
            }
        }];
    }

}

- (void)photoClick {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    // 判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerController代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取点击的正方形图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //头像上传
    self.mineModel.iconImg = imageData;
    MPWeakSelf(self)
    [[AboutAPI shareManager] upLoadUserInfo:self.mineModel IsSuccess:^(BOOL isSuccess) {
        NSLog(@"%zd",isSuccess);
        if (!isSuccess) {
            [MBProgressHUD showInfo:@"上传头像失败,请重试" ToView:weakself.view];
        }
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - textFiled delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    //头像上传
    self.mineModel.nickName = textField.text;
    MPWeakSelf(self)
    [[AboutAPI shareManager] upLoadUserInfo:self.mineModel IsSuccess:^(BOOL isSuccess) {
        NSLog(@"%zd",isSuccess);
        if (!isSuccess) {
            [MBProgressHUD showInfo:@"修改昵称失败,请重试" ToView:weakself.view];
        }
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AboutTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MPWeakSelf(self)
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"我的设计";
        cell.cellSelectAction = ^() {
            [weakself enterMyDesign];
        };
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"我的图册";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"关于我们";
    }
    return cell;
}

#pragma mark - enterNextPage
- (void)enterMyDesign {
    [self.navigationController pushViewController:[MyDesignViewController new] animated:YES];
}

#pragma mark - setConfig
- (BOOL)isCellNib {
    return YES;
}

- (NSArray *)cellReuseId {
    return @[NSStringFromClass([AboutTableViewCell class])];
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
