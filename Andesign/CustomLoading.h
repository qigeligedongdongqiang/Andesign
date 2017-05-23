//
//  CustomLoading.h
//  Nicomama
//
//  Created by Ngmm_Jadon on 2017/3/6.
//  Copyright © 2017年 XinYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomLoading : NSObject

+ (instancetype)sharedManager;

- (void)showLoadingTo:(UIView *)view;
- (void)hideLoadingFor:(UIView *)view;

@end
