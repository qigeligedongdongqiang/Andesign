//
//  AboutAPI.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "AboutAPI.h"
#import "MineModel.h"

@implementation AboutAPI

+ (instancetype)shareManager {
    static AboutAPI *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AboutAPI alloc] init];
    });
    return instance;
}

- (void)upLoadUserInfo:(MineModel *)mineModel IsSuccess:(void (^)(BOOL isSuccess))isSuccess {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    [db jq_createTable:kMineInfoTableName dicOrModel:[MineModel class] primaryKey:@"userId"];
    NSString *sqlStr = [NSString stringWithFormat:@"where userId = %@",mineModel.userId];
    NSArray *models = [db jq_lookupTable:kMineInfoTableName dicOrModel:[MineModel class] whereFormat:sqlStr];
    if (models.count>0) {
        BOOL isUpdate = [db jq_updateTable:kMineInfoTableName dicOrModel:mineModel whereFormat:sqlStr];
        if (isUpdate) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    } else {
        BOOL isInsert = [db jq_insertTable:kMineInfoTableName dicOrModel:mineModel];
        if (isInsert) {
            isSuccess(YES);
        } else {
            isSuccess(NO);
        }
    }
    [db close];
}

- (void)getUserInfo:(void (^)(MineModel *model))mineModel {
    JQFMDB *db = [JQFMDB shareDatabase:kDataBaseName];
    BOOL isExist = [db jq_isExistTable:kMineInfoTableName];
    if (isExist) {
        NSArray *mineModels = [db jq_lookupTable:kMineInfoTableName dicOrModel:[MineModel class] whereFormat:nil];
        MineModel *mine = [mineModels firstObject];
        mineModel(mine);
    } else {
        MineModel *model = [[MineModel alloc] init];
        model.iconImg = UIImagePNGRepresentation([UIImage imageNamed:@"user_icon"]);
        model.nickName = @"请输入昵称";
        mineModel(model);
    }
    [db close];
}

@end
