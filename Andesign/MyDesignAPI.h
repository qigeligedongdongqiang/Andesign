//
//  MyDesignAPI.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeBlock)(BOOL isSuccess,NSNumber *relateId);

@class DesignModel;

@interface MyDesignAPI : NSObject

+ (instancetype)shareManager;

- (void)upLoadDesign:(DesignModel *)designModel complete:(completeBlock)completeAction;
- (void)getDesigns:(void (^)(NSArray *modelArr))modelArr;
- (void)deleteDesignWithDesignId:(NSNumber *)designId isSuccess:(void (^)(BOOL isSuccess))isSuccess;

@end
