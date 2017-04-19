//
//  EditViewController.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//
#import <Photos/Photos.h>

#import "EditViewController.h"
#import "EditNormalTableViewCell.h"
#import "EditImageTableViewCell.h"
#import "EditTextViewTableViewCell.h"

#import "QBImagePickerController.h"
#import "UIPlaceHolderTextView.h"

#import "DesignModel.h"
#import "PhotographyModel.h"
#import "ImageModel.h"

#import "MyDesignAPI.h"
#import "ImageAPI.h"

#define kMainImgNumber 1
#define kDetailImgNumber 18
#define kColumnNum 3
#define kMargin 10

typedef enum {
    PageTypeDesign,
    PageTypePhotography
}PageType;

typedef enum {
    ImgTypeNone,
    ImgTypeMain,
    ImgTypeDetail
}ImgType;

@interface EditViewController ()<UITextFieldDelegate,UITextViewDelegate,QBImagePickerControllerDelegate>

@property (nonatomic, assign) PageType pageType;

@property (nonatomic, assign) ImgType imgType;

@property (nonatomic, strong) DesignModel *designModel;
@property (nonatomic, strong) PhotographyModel *photographyModel;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *summaryStr;
@property (nonatomic, copy) NSString *detailStr;
/*
 主图模型数组
 */
@property (nonatomic, strong) NSMutableArray *mainImgArr;
/*
 详情图片模型数组
 */
@property (nonatomic, strong) NSMutableArray *detailImgArr;

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextField *summaryTextField;
@property (nonatomic, strong) UIPlaceHolderTextView *detailTextView;

@end

@implementation EditViewController

- (instancetype)initDesignWithDesignModel:(DesignModel *)designModel {
    if (self = [super init]) {
        _designModel = designModel;
        _pageType = PageTypeDesign;
    }
    return self;
}

- (instancetype)initPhotographyWithphotographyModel:(PhotographyModel *)photographyModel {
    if (self = [super init]) {
        _photographyModel = photographyModel;
        _pageType = PageTypePhotography;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.pageType == PageTypeDesign) {
        self.navigationItem.title = @"编辑设计";
        if (self.designModel) {
            [self getImageInfoWithDesignModel:self.designModel];
        } else {
            self.mainImgArr = [NSMutableArray array];
            self.detailImgArr = [NSMutableArray array];
        }
    } else if (self.pageType == PageTypePhotography) {
        self.navigationItem.title = @"编辑图册";
        if (self.photographyModel) {
            [self getImageInfoWithPhotographyModel:self.photographyModel];
        } else {
            self.mainImgArr = [NSMutableArray array];
            self.detailImgArr = [NSMutableArray array];
        }
    }
    
    self.imgType = ImgTypeNone;
    
    [self.tableView registerClass:[EditTextViewTableViewCell class] forCellReuseIdentifier:NSStringFromClass([EditTextViewTableViewCell class])];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -API
- (void)getImageInfoWithDesignModel:(DesignModel *)designModel {
    
}

- (void)getImageInfoWithPhotographyModel:(PhotographyModel *)photographyModel {
    
}

- (void)saveInfo {
    [self.view endEditing:YES];
    
    if (self.mainImgArr.count == 0) {
        [MBProgressHUD showAutoMessage:@"主图不能为空" ToView:nil];
    }
    
    if (self.titleTextField.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"标题不能为空" ToView:nil];
        return;
    }
    if (self.summaryTextField.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"摘要不能为空" ToView:nil];
        return;
    }
    if (self.detailTextView.text.length == 0) {
        [MBProgressHUD showAutoMessage:@"详细描述不能为空" ToView:nil];
        return;
    }
    
    if (self.detailImgArr.count == 0) {
        [MBProgressHUD showAutoMessage:@"详情图片不能为空" ToView:nil];
    }
    
    if (self.pageType == PageTypeDesign) {
        DesignModel *designModel = [[DesignModel alloc] init];
        designModel.designId = @1;
        designModel.title = self.titleTextField.text;
        designModel.summary = self.summaryTextField.text;
        designModel.detailText = self.detailTextView.text;
        
        MPWeakSelf(self)
        [[MyDesignAPI shareManager] upLoadDesign:designModel complete:^(BOOL isSuccess, NSNumber *relateId) {
//            NSLog(@"%zd，%@",isSuccess,relateId);
            MPStrongSelf(self)
            if (isSuccess) {
                
                for (ImageModel *imageModel in strongself.mainImgArr) {
                    imageModel.relateId = relateId;
                }
                [[ImageAPI shareManager] upLoadDesignImages:strongself.mainImgArr IsSuccess:^(BOOL isSuccess) {
                    if (!isSuccess) {
                        [MBProgressHUD showInfo:@"保存失败,请重试" ToView:strongself.view];
                    }
                }];
                
                for (ImageModel *imageModel in strongself.detailImgArr) {
                    imageModel.relateId = relateId;
                }
                [[ImageAPI shareManager] upLoadDesignImages:strongself.detailImgArr IsSuccess:^(BOOL isSuccess) {
                    if (!isSuccess) {
                        [MBProgressHUD showInfo:@"保存失败,请重试" ToView:strongself.view];
                    }
                }];
                
            } else {
                [MBProgressHUD showInfo:@"保存失败,请重试" ToView:strongself.view];
            }
        }];
    } else if (self.pageType == PageTypePhotography) {
        
    }
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPWeakSelf(self)
    if (indexPath.row == 0) {
        EditImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditImageTableViewCell class])];
        cell.titleLabel.text = @"主图：";
        cell.maxImageNumber = kMainImgNumber;
        cell.imagesArray = self.mainImgArr;
        cell.addImgAction = ^() {
            MPStrongSelf(self)
            strongself.imgType = ImgTypeMain;
            [strongself showActionForPhoto];
        };
        cell.deleteImgAction = ^(NSInteger index) {
            MPStrongSelf(self)
            [strongself.mainImgArr removeObjectAtIndex:index];
            [strongself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    } else if (indexPath.row == 1) {
        EditNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditNormalTableViewCell class])];
        cell.titleLabel.text = @"标题：";
        self.titleTextField = cell.inputTextField;
        cell.inputTextField.placeholder = @"请输入标题";
        cell.inputTextField.delegate = self;
        cell.inputTextField.tag = 10;
        if (self.pageType == PageTypeDesign) {
            if (self.designModel.title) {
                cell.inputTextField.text = self.designModel.title;
            }
        } else if (self.pageType == PageTypePhotography) {
            if (self.photographyModel.title) {
                cell.inputTextField.text = self.photographyModel.title;
            }
        }
        return cell;
    } else if (indexPath.row == 2) {
        EditNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditNormalTableViewCell class])];
        cell.titleLabel.text = @"摘要：";
        self.summaryTextField = cell.inputTextField;
        cell.inputTextField.placeholder = @"请输入摘要";
        cell.inputTextField.delegate = self;
        cell.inputTextField.tag = 20;
        if (self.pageType == PageTypeDesign) {
            if (self.designModel.summary) {
                cell.inputTextField.text = self.designModel.summary;
            }
        } else if (self.pageType == PageTypePhotography) {
            if (self.photographyModel.summary) {
                cell.inputTextField.text = self.photographyModel.summary;
            }
        }
        return cell;
    } else if (indexPath.row == 3) {
        EditImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditImageTableViewCell class])];
        cell.titleLabel.text = @"详情图片：";
        cell.maxImageNumber = kDetailImgNumber;
        cell.imagesArray = self.detailImgArr;
        cell.addImgAction = ^() {
            MPStrongSelf(self)
            strongself.imgType = ImgTypeDetail;
            [strongself showActionForPhoto];
        };
        cell.deleteImgAction = ^(NSInteger index) {
            MPStrongSelf(self)
            [strongself.detailImgArr removeObjectAtIndex:index];
            [strongself.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    } else if (indexPath.row == 4) {
        EditTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EditTextViewTableViewCell class])];
        cell.titleLabel.text = @"详细描述：";
        self.detailTextView = cell.detailTextView;
        cell.detailTextView.placeholder = @"请输入详细的描述";
        cell.detailTextView.delegate = self;
        if (self.pageType == PageTypeDesign) {
            if (self.designModel.detailText) {
                cell.detailTextView.text = self.designModel.detailText;
            }
        } else if (self.pageType == PageTypePhotography) {
            if (self.photographyModel.detailText) {
                cell.detailTextView.text = self.photographyModel.detailText;
            }
        }
        return cell;
    }
    return nil;
}


#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat cellWidthHeight = (Main_Screen_Width - kMargin * (kColumnNum + 1))/kColumnNum;
        NSInteger ImageCount = (self.mainImgArr.count < kMainImgNumber) ? self.mainImgArr.count +1:kMainImgNumber;
        NSInteger row = ceilf((float)(ImageCount)/kColumnNum);
        CGFloat height = cellWidthHeight * row + kMargin * (row - 1) + 50;
        return height;
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        return 50;
    } else if (indexPath.row == 3) {
        CGFloat cellWidthHeight = (Main_Screen_Width - kMargin * (kColumnNum + 1))/kColumnNum;
        NSInteger ImageCount = (self.detailImgArr.count < kDetailImgNumber) ? self.detailImgArr.count +1:kDetailImgNumber;
        NSInteger row = ceilf((float)(ImageCount)/kColumnNum);
        CGFloat height = cellWidthHeight * row + kMargin * (row - 1) + 50;
        return height;
    } else if (indexPath.row == 4) {
        return 250;
    }
    return 0;
}

#pragma mark - getImg
- (void)showActionForPhoto {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoClick];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [sheet addAction:action1];
    [sheet addAction:action2];
    
    [self presentViewController:sheet animated:YES completion:nil];
}

#pragma mark - openImagePicker
- (BOOL)checkPhotoLibraryAuthorizationStatus
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (PHAuthorizationStatusDenied == authStatus ||
        PHAuthorizationStatusRestricted == authStatus) {
        [MBProgressHUD showAutoMessage:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限" ToView:nil];
        return NO;
        }
    return YES;
}

- (void)photoClick {
    //相册
    if (![self checkPhotoLibraryAuthorizationStatus]) {
        return;
    }
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    if (self.imgType == ImgTypeMain) {
        imagePickerController.maximumNumberOfSelection = kMainImgNumber;
    } else if (self.imgType == ImgTypeDetail) {
        imagePickerController.maximumNumberOfSelection = kDetailImgNumber;
    }
    imagePickerController.showsNumberOfSelectedAssets = YES;
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;
    imagePickerController.assetCollectionSubtypes = @[
                                                      @(PHAssetCollectionSubtypeSmartAlbumUserLibrary), // Camera Roll
                                                      @(PHAssetCollectionSubtypeAlbumMyPhotoStream), // My Photo Stream
                                                      ];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    
    [self presentViewController:imagePickerController animated:NO completion:nil];
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (PHAsset *asset in assets) {
        __block NSData *data;
        if (asset.mediaType == PHAssetMediaTypeImage) {
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData *imageData,NSString *dataUTI,
UIImageOrientation orientation,NSDictionary *info) {
                 data = [NSData dataWithData:imageData];
             }];
        }
        ImageModel *model = [[ImageModel alloc] init];
        model.widthHeightScale = [NSNumber numberWithInteger:(asset.pixelWidth/asset.pixelHeight)];
        model.img = data;
        if (self.imgType == ImgTypeMain) {
            model.isMain = YES;
        } else if (self.imgType == ImgTypeDetail) {
            model.isMain = NO;
        }
        [tempArr addObject:model];
    }
    if (self.imgType == ImgTypeMain) {
        self.mainImgArr = tempArr;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    } else if (self.imgType == ImgTypeDetail) {
        self.detailImgArr = tempArr;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setConfig
- (UIImage *)set_leftBarButtonItemWithImage {
    return [UIImage imageNamed:@"back_icon"];
}

- (UIButton *)set_rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    return button;
}

- (void)left_button_event:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)right_button_event:(UIButton *)sender {
    [self saveInfo];
}

#pragma mark - setConfig
- (BOOL)isCellNib {
    return YES;
}

- (NSArray *)cellReuseId {
    return @[NSStringFromClass([EditNormalTableViewCell class]),NSStringFromClass([EditImageTableViewCell class])];
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
