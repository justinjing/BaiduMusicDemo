//
//  TouchView.m
//  BaiduMusicAddDemo
//
//  Created by da zhan on 13-6-18.
//  Copyright (c) 2013年 da zhan. All rights reserved.
//

#import "TouchView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan===%d",self.tag);
//    UITouch * touchBegan = [touches anyObject];
//    _tBegan = [ touchBegan locationInView:self];
//    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"touchesMoved===%d",self.tag);
//    UITouch * touchEnded = [touches anyObject];
//    _tEnded = [ touchEnded locationInView: self];
//    NSInteger distanceHorizontal = ABS( _tEnded.x - _tBegan.x );
//    NSInteger distanceVertical = ABS( _tEnded.y - _tBegan.y );
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"touchesEnded===%d",self.tag);
//    UITouch * touchEnded = [touches anyObject];
//    _tEnded = [ touchEnded locationInView: [[self superview] superview]];
    [self tranAction];
    
 }

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    NSLog(@"touchesCancelled===%d",self.tag);
//    UITouch * touchEnded = [touches anyObject];
//      _tEnded = [ touchEnded locationInView: [[self superview] superview]];
//    NSLog(@"%f,%f",_tEnded.x,_tEnded.y);   
    
}
- (void)tranAction {
    
    CGPoint fromPoint = self.center;
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(20, 570);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(20,0)];
    
    //关键帧
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //旋转变化
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //x，y轴缩小到0.1,Z 轴不变
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.4];
    opacityAnim.removedOnCompletion = YES;
    
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [self.layer addAnimation:animGroup forKey:nil];
    
}


@end
