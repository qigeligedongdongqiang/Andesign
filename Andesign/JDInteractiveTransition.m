//
//  JDInteractiveTransition.m
//  Andesign
//
//  Created by Ngmm_Jadon on 2017/4/26.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "JDInteractiveTransition.h"
#import "UIImage+Capture.h"
#import "DetailBottomView.h"

#define kExpandAnimationDuration 0.5

@implementation JDInteractiveTransition

+ (instancetype)transitionWithTransitionType:(JDTransitionType)type {
    return [[JDInteractiveTransition alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(JDTransitionType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (_transitionStyle == JDTransitionStyleExpand) {
        return kExpandAnimationDuration;
    }
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case JDTransitionTypePresent:
            if (_transitionStyle == JDTransitionStyleExpand) {
                [self expandPresentAnimation:transitionContext];
            }
            break;
            
        case JDTransitionTypeDismiss:
            if (_transitionStyle == JDTransitionStyleExpand) {
                [self expandDismissAnimation:transitionContext];
            }
            break;
    }
}

#pragma mark - expand present dismiss animation
- (void)expandPresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIImageView *snapView = [[UIImageView alloc] initWithImage:[UIImage screenshotWithView:fromVC.view limitWidth:0]];
    snapView.frame = fromVC.view.frame;
    toVC.view.alpha = 0.0f;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:snapView];
    [containerView addSubview:toVC.view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_startFrame];
    imageView.image = _mainImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    DetailBottomView *detailsView = [[DetailBottomView alloc] initWithResources:_resources];
    detailsView.frame = _startFrame;
    
    [snapView addSubview:detailsView];
    [snapView addSubview:imageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame   = CGRectMake(0, 0, toVC.view.frame.size.width, (toVC.view.frame.size.height/2)+40);
        detailsView.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), toVC.view.frame.size.width, toVC.view.frame.size.height - imageView.frame.size.height);
    }];
    
    [UIView animateWithDuration:0.2 delay:0.3 options:0 animations:^{
        toVC.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [snapView  removeFromSuperview];
    }];
}

- (void)expandDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIImageView *snapView = [[UIImageView alloc] initWithImage:[UIImage screenshotWithView:toVC.view limitWidth:0]];
    snapView.frame = toVC.view.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:snapView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fromVC.view.frame.size.width, (fromVC.view.frame.size.height/2)+40)];
    imageView.image = _mainImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    DetailBottomView *detailsView = [[DetailBottomView alloc] initWithResources:_resources];
    detailsView.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), fromVC.view.frame.size.width, fromVC.view.frame.size.height - imageView.frame.size.height);
    
    [snapView addSubview:detailsView];
    [snapView addSubview:imageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame   = _startFrame;
        detailsView.frame = _startFrame;
        fromVC.view.alpha = 0.0f;
    }];
    [UIView animateWithDuration:0.2 delay:0.3 options:0 animations:^{
        snapView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [snapView removeFromSuperview];
    }];
}

@end
