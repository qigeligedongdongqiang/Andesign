//
//  EditViewController.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "BaseTableViewController.h"

@class DesignModel;
@class PhotographyModel;

@interface EditViewController : BaseTableViewController

- (instancetype)initDesignWithDesignModel:(DesignModel *)designModel;

- (instancetype)initPhotographyWithphotographyModel:(PhotographyModel *)photographyModel;

@end
