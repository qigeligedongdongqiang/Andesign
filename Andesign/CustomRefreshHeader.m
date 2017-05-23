//
//  CustomRefreshHeader.m
//  Nicomama
//
//  Created by Ngmm_Jadon on 2017/1/22.
//  Copyright © 2017年 XinYu. All rights reserved.
//

#import "CustomRefreshHeader.h"

@implementation CustomRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare {
    [super prepare];
    
//    NSMutableArray *loadingImageArr = [NSMutableArray array];
//    for (int i = 0; i<60; i++) {
//        NSString *imgName = [NSString stringWithFormat:@"ngmm_%02d",i];
//        UIImage *image = [UIImage imageNamed:imgName];
//        [loadingImageArr addObject:image];
//    }
//    [self setImages:loadingImageArr forState:MJRefreshStateIdle];
//    [self setImages:loadingImageArr duration:2 forState:MJRefreshStateRefreshing];
    UIImage *image = [UIImage imageNamed:@"Refresh"];
//    imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"rotation"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI*2);
    animation.duration = 1;
//    animation.repeatCount =
//    self.gifView.image = image;
    [self setImages:@[image] forState:MJRefreshStateRefreshing];
    [self.gifView.layer addAnimation:animation forKey:@"rotation"];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    
}

-(void)placeSubviews {
    [super placeSubviews];
    
//    if(self.state == MJRefreshStateRefreshing){
//        NSLog(@"%f",self.gifView.mj_x);
//        self.gifView.mj_x = (SCREEN_WIDTH-self.gifView.bounds.size.width)/2;
//        self.stateLabel.mj_x = 30;
//        self.stateLabel.hidden = YES;
//    } else {
//        self.stateLabel.hidden = NO;
//    }
    
}

@end
