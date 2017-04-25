//
//  MyPhotoAPI.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "MyPhotoAPI.h"
#import "PhotographyModel.h"

@implementation MyPhotoAPI

+ (instancetype)shareManager {
    static MyPhotoAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MyPhotoAPI alloc] init];
    });
    return instance;
}

- (void)upLoadPhoto:(PhotographyModel *)photographyModel complete:(completeBlock)completeAction {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isCreate = [db jq_createTable:kPhotographyTableName dicOrModel:[PhotographyModel class] primaryKey:@"photographyId"];
    if (!isCreate) {
        BOOL isExist = [db jq_isExistTable:kPhotographyTableName];
        if (!isExist) {
            completeAction(NO,nil);
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"where photographyId = %@",photographyModel.photographyId];
    NSArray *models = [db jq_lookupTable:kPhotographyTableName dicOrModel:[PhotographyModel class] whereFormat:sqlStr];
    if (models.count>0) {
        BOOL isUpdate = [db jq_updateTable:kPhotographyTableName dicOrModel:photographyModel whereFormat:sqlStr];
        if (isUpdate) {
            completeAction(YES,photographyModel.photographyId);
        } else {
            completeAction(NO,photographyModel.photographyId);
        }
    } else {
        BOOL isInsert = [db jq_insertTable:kPhotographyTableName dicOrModel:photographyModel];
        if (isInsert) {
            NSString *sqlStr1 = [NSString stringWithFormat:@"where title = '%@' and summary = '%@' and detailText = '%@' ",photographyModel.title,photographyModel.summary,photographyModel.detailText];
            NSArray *photographyModels = [db jq_lookupTable:kPhotographyTableName dicOrModel:[PhotographyModel class] whereFormat:sqlStr1];
            PhotographyModel *photographyModel1 = [photographyModels firstObject];
            completeAction(YES,photographyModel1.photographyId);
        } else {
            completeAction(NO,nil);
        }
    }
    [db close];
}

- (void)getPhotos:(void (^)(NSArray *))modelArr {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isExist = [db jq_isExistTable:kPhotographyTableName];
    if (isExist) {
        NSArray *photographyModels = [db jq_lookupTable:kPhotographyTableName dicOrModel:[PhotographyModel class] whereFormat:nil];
        modelArr(photographyModels);
    } else {
        modelArr(nil);
    }
    [db close];
}

- (void)deletePhotoWithPhotographyId:(NSNumber *)photographyId isSuccess:(void (^)(BOOL))isSuccess{
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isExist = [db jq_isExistTable:kPhotographyTableName];
    if (isExist) {
        NSString *sqlStr = [NSString stringWithFormat:@"where photographyId = %@",photographyId];
        BOOL isDelete = [db jq_deleteTable:kPhotographyTableName whereFormat:sqlStr];
        if (isDelete) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    } else {
        isSuccess(NO);
    }
    [db close];
}

@end
