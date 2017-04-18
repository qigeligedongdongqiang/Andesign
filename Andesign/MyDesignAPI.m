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

- (void)upLoadDesign:(DesignModel *)designModel IsSuccess:(void (^)(BOOL))isSuccess {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    [db jq_createTable:kDesignTableName dicOrModel:[DesignModel class] primaryKey:@"designId"];
    NSString *sqlStr = [NSString stringWithFormat:@"where designId = %@",designModel.designId];
    NSArray *models = [db jq_lookupTable:kMineInfoTableName dicOrModel:[DesignModel class] whereFormat:sqlStr];
    if (models.count>0) {
        BOOL isUpdate = [db jq_updateTable:kMineInfoTableName dicOrModel:designModel whereFormat:sqlStr];
        if (isUpdate) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    } else {
        BOOL isInsert = [db jq_insertTable:kMineInfoTableName dicOrModel:designModel];
        if (isInsert) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    }
    [db close];
}

- (void)getDesigns:(void (^)(NSArray *))modelArr {
    
}

- (void)getDesign:(void (^)(DesignModel *))designModel WithDesignId:(NSNumber *)designId {
    
}

@end
