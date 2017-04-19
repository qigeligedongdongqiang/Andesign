//
//  ImageAPI.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/1.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "ImageAPI.h"
#import "ImageModel.h"

@implementation ImageAPI

+ (instancetype)shareManager {
    static ImageAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ImageAPI alloc] init];
    });
    return instance;
}

- (void)upLoadDesignImages:(NSArray *)imageModels IsSuccess:(void (^)(BOOL))isSuccess {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isCreate = [db jq_createTable:kDesignImageTableName dicOrModel:[ImageModel class] primaryKey:nil];
    if (!isCreate) {
        BOOL isExist = [db jq_isExistTable:kDesignImageTableName];
        if (!isExist) {
            isSuccess(NO);
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"where relateId = %@",[imageModels[0] relateId]];
//    BOOL isInsert = [db jq_insertTable:kDesignImageTableName dicOrModelArray:imageModels];
//    if (isInsert) {
//        isSuccess(YES);
//    } else {
//        isSuccess(NO);
//    }

//    NSArray *models = [db jq_lookupTable:kDesignImageTableName dicOrModel:[ImageModel class] whereFormat:sqlStr];
//    if (models.count>0) {
//        BOOL isUpdate = [db jq_updateTable:kDesignImageTableName dicOrModel:imageModel whereFormat:sqlStr];
//        if (isUpdate) {
//            isSuccess(YES);
//        } else {
//            isSuccess(NO);
//        }
//    } else {
//        BOOL isInsert = [db jq_insertTable:kDesignImageTableName dicOrModel:imageModel];
//        if (isInsert) {
//            isSuccess(YES);
//        } else {
//            isSuccess(NO);
//        }
//    }
    [db close];
}

- (void)upLoadPhotographyImages:(NSArray *)imageModels IsSuccess:(void (^)(BOOL))isSuccess {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isCreate = [db jq_createTable:kPhotographyTableName dicOrModel:[ImageModel class] primaryKey:nil];
    if (!isCreate) {
        BOOL isExist = [db jq_isExistTable:kPhotographyTableName];
        if (!isExist) {
            isSuccess(NO);
        }
    }
    NSString *sqlStr = [NSString stringWithFormat:@"where relateId = %@",imageModel.relateId];
    NSArray *models = [db jq_lookupTable:kPhotographyTableName dicOrModel:[ImageModel class] whereFormat:sqlStr];
    if (models.count>0) {
        BOOL isUpdate = [db jq_updateTable:kPhotographyTableName dicOrModel:imageModel whereFormat:sqlStr];
        if (isUpdate) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    } else {
        BOOL isInsert = [db jq_insertTable:kPhotographyTableName dicOrModel:imageModel];
        if (isInsert) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    }
    [db close];
}


@end
