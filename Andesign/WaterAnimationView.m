//
//  WaterAnimationView.m
//  AnimationDemo
//
//  Created by Ngmm_Jadon on 2017/5/16.
//  Copyright © 2017年 Ngmm_Jadon. All rights reserved.
//

#import "WaterAnimationView.h"

#define KWaveHeight 15
#define KWaveOffsetY 30
#define kWaveCycle 1
#define KWaveSpeed 0.01

@interface WaterAnimationView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer1;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat waveOffsetX;

@end

@implementation WaterAnimationView

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self setUp];
//    }
//    return  self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setUp];
}

- (void)setUp{    
    _shapeLayer1 = [CAShapeLayer layer];
    _shapeLayer1.fillColor = [UIColor colorWithWhite:0.97 alpha:0.5].CGColor;
    [self.layer addSublayer:_shapeLayer1];
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.fillColor = [UIColor colorWithWhite:0.97 alpha:0.5].CGColor;
    [self.layer addSublayer:_shapeLayer2];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    _waveOffsetX = 0.0f;
}

- (void)getCurrentWave {
    CGFloat waveHeightAmplitude = KWaveHeight;
    CGFloat waveWidth = self.bounds.size.width;
    CGFloat y = 0;
    self.waveOffsetX += 2 * M_PI * KWaveSpeed;
    
    //绘制第一条波形
    CGMutablePathRef path1 = CGPathCreateMutable();
    
    CGPathMoveToPoint(path1, nil, 0, self.bounds.size.height - KWaveOffsetY);
    for (CGFloat x = 0; x <= waveWidth; x ++) {
        y = waveHeightAmplitude * sinf(kWaveCycle * (2 * M_PI * x / waveWidth) - self.waveOffsetX) + (self.bounds.size.height - KWaveOffsetY);
        CGPathAddLineToPoint(path1, nil, x, y);
    }
    CGPathAddLineToPoint(path1, nil, waveWidth,  self.bounds.size.height);
    CGPathAddLineToPoint(path1, nil, 0, self.bounds.size.height);
    
    //结束绘图信息
    CGPathCloseSubpath(path1);
    self.shapeLayer1.path = path1;
    
    //释放绘图路径
    CGPathRelease(path1);
    
    //绘制第二条波形
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    CGPathMoveToPoint(path2, nil, 0, self.bounds.size.height - KWaveOffsetY - KWaveHeight * 0.5);
    for (CGFloat x = 0; x <= waveWidth; x ++) {
        y = waveHeightAmplitude * sinf(kWaveCycle * (2 *  M_PI * x / waveWidth) - M_PI - self.waveOffsetX*1.5) + (self.bounds.size.height - KWaveOffsetY);
        CGPathAddLineToPoint(path2, nil, x, y);
    }
    CGPathAddLineToPoint(path2, nil, waveWidth,  self.bounds.size.height);
    CGPathAddLineToPoint(path2, nil, 0, self.bounds.size.height);
    
    //结束绘图信息
    CGPathCloseSubpath(path2);
    self.shapeLayer2.path = path2;
    
    //释放绘图路径
    CGPathRelease(path2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
