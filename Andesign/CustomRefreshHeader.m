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
//        NSString *imgName = [NSString stringWithFormat:@"refresh_%02d",i];
//        UIImage *image = [UIImage imageNamed:imgName];
//        [loadingImageArr addObject:image];
//    }
//    [self setImages:loadingImageArr forState:MJRefreshStateIdle];
//    [self setImages:loadingImageArr duration:2 forState:MJRefreshStateRefreshing];
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
