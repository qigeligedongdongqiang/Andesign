//
//  EditViewController.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum {
    PageTypeDesign,
    PageTypePhotography
}PageType;

@class EditDesignModel;

@interface EditViewController : BaseTableViewController

- (instancetype)initWithPageType:(PageType)pageType EditModel:(EditDesignModel *)editModel;

@end
