//
//  MyPhotoAPI.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/25.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeBlock)(BOOL isSuccess,NSNumber *relateId);

@class PhotographyModel;

@interface MyPhotoAPI : NSObject

+ (instancetype)shareManager;

- (void)upLoadPhoto:(PhotographyModel *)photographyModel complete:(completeBlock)completeAction;
- (void)getPhotos:(void (^)(NSArray *modelArr))modelArr;
- (void)deletePhotoWithPhotographyId:(NSNumber *)photographyId isSuccess:(void (^)(BOOL isSuccess))isSuccess;

@end
