//
//  AboutAPI.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/27.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MineModel;

@interface AboutAPI : NSObject

+ (instancetype)shareManager;

- (void)upLoadUserInfo:(MineModel *)mineModel IsSuccess:(void (^)(BOOL isSuccess))isSuccess;
- (void)getUserInfo:(void (^)(MineModel *model))mineModel;

@end
