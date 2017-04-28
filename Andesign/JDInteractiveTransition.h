//
//  JDInteractiveTransition.h
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,JDTransitionType) {
    JDTransitionTypePresent = 0,
    JDTransitionTypeDismiss
};

typedef NS_ENUM(NSInteger,JDTransitionStyle) {
    JDTransitionStyleExpand = 0,//展开风格
};

@interface JDInteractiveTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) JDTransitionType type;
@property (nonatomic, assign) JDTransitionStyle transitionStyle;
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) id resources;
@property (nonatomic, strong) UIImage *mainImage;

+ (instancetype)transitionWithTransitionType:(JDTransitionType)type;
- (instancetype)initWithTransitionType:(JDTransitionType)type;

@end
