//
//  MyDesignAPI.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyDesignAPI.h"
#import "DesignModel.h"

@implementation MyDesignAPI

+ (instancetype)shareManager {
    static MyDesignAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MyDesignAPI alloc] init];
    });
    return instance;
}

- (void)upLoadDesign:(DesignModel *)designModel complete:(completeBlock)completeAction {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isCreate = [db jq_createTable:kDesignTableName dicOrModel:[DesignModel class] primaryKey:@"designId"];
    if (!isCreate) {
        BOOL isExist = [db jq_isExistTable:kDesignTableName];
        if (!isExist) {
            completeAction(NO,nil);
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"where designId = %@",designModel.designId];
    NSArray *models = [db jq_lookupTable:kDesignTableName dicOrModel:[DesignModel class] whereFormat:sqlStr];
    if (models.count>0) {
        BOOL isUpdate = [db jq_updateTable:kDesignTableName dicOrModel:designModel whereFormat:sqlStr];
        if (isUpdate) {
            completeAction(YES,designModel.designId);
        } else {
            completeAction(NO,designModel.designId);
        }
    } else {
        BOOL isInsert = [db jq_insertTable:kDesignTableName dicOrModel:designModel];
        if (isInsert) {
            NSString *sqlStr1 = [NSString stringWithFormat:@"where title = '%@' and summary = '%@' and detailText = '%@' ",designModel.title,designModel.summary,designModel.detailText];
            NSArray *designModels = [db jq_lookupTable:kDesignTableName dicOrModel:[DesignModel class] whereFormat:sqlStr1];
            DesignModel *designModel1 = [designModels firstObject];
            completeAction(YES,designModel1.designId);
        } else {
            completeAction(NO,nil);
        }
    }
    [db close];
}

- (void)getDesigns:(void (^)(NSArray *))modelArr {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isExist = [db jq_isExistTable:kDesignTableName];
    if (isExist) {
        NSArray *designModels = [db jq_lookupTable:kDesignTableName dicOrModel:[DesignModel class] whereFormat:nil];
        modelArr(designModels);
    } else {
        modelArr(nil);
    }
    [db close];
}

@end
