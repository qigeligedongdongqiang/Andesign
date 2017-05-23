//
//  CustomLoading.m
//  Nicomama
//
//  Created by Ngmm_Jadon on 2017/3/6.
//  Copyright © 2017年 XinYu. All rights reserved.
//

#import "CustomLoading.h"

@implementation CustomLoading

+ (instancetype)sharedManager {
    static CustomLoading *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CustomLoading alloc] init];
    });
    return instance;
}

- (void)showLoadingTo:(UIView *)view {
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    //标记一下类型是loading
    hud.tag = 20000;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"Loading"];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
    rotateAnimation.duration = .5f;
    rotateAnimation.repeatDuration = INFINITY;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [imgView.layer addAnimation:rotateAnimation forKey:@"transform.rotation.z"];
    hud.customView = imgView;
    
    hud.label.text = @"We are coming···";
    hud.label.font = [UIFont customFontOfSize:17 withName:kTitleFontName withExtension:@"otf"];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];

}

- (void)hideLoadingFor:(UIView *)view {
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud.tag == 20000) {
        [MBProgressHUD hideHUDForView:view animated:NO];
    }
}

@end
