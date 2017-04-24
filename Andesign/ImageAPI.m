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
    BOOL isDelete = [db jq_deleteTable:kDesignImageTableName whereFormat:sqlStr];
    BOOL isInsert = [db jq_insertTable:kDesignImageTableName dicOrModelArray:imageModels];
    if (isDelete && isInsert) {
        isSuccess(YES);
    } else {
        isSuccess(NO);
    }
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
    NSString *sqlStr = [NSString stringWithFormat:@"where relateId = %@",[imageModels[0] relateId]];
    BOOL isDelete = [db jq_deleteTable:kPhotographyTableName whereFormat:sqlStr];
    BOOL isInsert = [db jq_insertTable:kPhotographyTableName dicOrModelArray:imageModels];
    if (isDelete && isInsert) {
        isSuccess(YES);
    } else {
        isSuccess(NO);
    }
    [db close];
}

- (void)getDesignImages:(void (^)(NSArray *))modelArr WithRelateId:(NSNumber *)relateId{
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isExist = [db jq_isExistTable:kDesignImageTableName];
    if (isExist) {
        NSString *sqlStr = [NSString stringWithFormat:@"where relateId = %@",relateId];
        NSArray *designImageModels = [db jq_lookupTable:kDesignImageTableName dicOrModel:[ImageModel class] whereFormat:sqlStr];
        modelArr(designImageModels);
    } else {
        modelArr(nil);
    }
    [db close];
}

@end
