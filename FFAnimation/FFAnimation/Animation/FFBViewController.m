//
//  FFBViewController.m
//  FFAnimation
//
//  Created by 张玲玉 on 2017/2/9.
//  Copyright © 2017年 bj.zly.com. All rights reserved.
//

#import "FFBViewController.h"
#import "UIView+Extension.h"

@interface FFBViewController ()

@end

@implementation FFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self animationA];
    [self animationB:0.8];
}

-(void)animationA
{
    double w=40, gap=(kMainScreen_Width-w)/2.0;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(gap, 250, w, w)];
    view.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view];
    
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(w/2, w/2) radius:w/2 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    
    //先画一个圆
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=path.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    layer.lineWidth=3.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [view.layer addSublayer:layer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=.6;
    animation.repeatCount=HUGE;//永久重复动画
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
}

-(void)animationB:(CGFloat)toValue
{
    double w=70, gap=(kMainScreen_Width-w)/2.0;
    
    CGRect rect = CGRectMake(gap, 120, w, w);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.path=path.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;//填充色
    layer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    layer.lineWidth=5.0f;
    layer.lineCap=kCALineCapRound;//线框类型
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:toValue];
    animation.duration=2.0;
    //animation.repeatCount=HUGE;//永久重复动画
    //animation.delegate=self;
    //removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    //fillMode：决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后
    //autoreverses:动画结束时是否执行逆动画
    //timingFunction:设定动画的速度变化
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"animation"];
}

@end
