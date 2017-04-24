//
//  ImageAPI.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/1.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageModel;

@interface ImageAPI : NSObject

+ (instancetype)shareManager;

- (void)upLoadDesignImages:(NSArray *)imageModels IsSuccess:(void (^)(BOOL isSuccess))isSuccess;
- (void)upLoadPhotographyImages:(NSArray *)imageModels IsSuccess:(void (^)(BOOL isSuccess))isSuccess;
- (void)getDesignImages:(void (^)(NSArray *modelArr))modelArr WithRelateId:(NSNumber *)relateId;
//- (void)getDesign:(void (^)(DesignModel *designModel))designModel WithDesignId:(NSNumber *)designId;

@end
