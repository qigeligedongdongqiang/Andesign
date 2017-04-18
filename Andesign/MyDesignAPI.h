//
//  MyDesignAPI.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/3/28.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DesignModel;

@interface MyDesignAPI : NSObject

+ (instancetype)shareManager;

- (void)upLoadDesign:(DesignModel *)designModel IsSuccess:(void (^)(BOOL isSuccess))isSuccess;
- (void)getDesigns:(void (^)(NSArray *modelArr))modelArr;
- (void)getDesign:(void (^)(DesignModel *designModel))designModel WithDesignId:(NSNumber *)designId;

@end
