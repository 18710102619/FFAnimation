//
//  FFCViewController.m
//  FFAnimation
//
//  Created by 张玲玉 on 2017/2/9.
//  Copyright © 2017年 bj.zly.com. All rights reserved.
//

#import "FFCViewController.h"
#import "UIView+Extension.h"

@interface FFCViewController ()

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UIBezierPath *path;

@end

@implementation FFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animationA];
    [self animationB];
}

-(void)animationA
{
    double w=100, gap=(kMainScreen_Width-w)/2.0;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(gap, 120, w, w)];
    view.layer.backgroundColor = [UIColor clearColor].CGColor;
    [self.view addSubview:view];
    
    //CAShapeLayer和CAReplicatorLayer都是CALayer的子类
    //CAShapeLayer的实现必须有一个path，可以配合贝塞尔曲线
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = view.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = [UIColor magentaColor].CGColor;//填充色
    pulseLayer.opacity = 0.0;
    
    //可以复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = view.bounds;
    replicatorLayer.instanceCount = 3;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 0.7;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [view.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = replicatorLayer.instanceCount*replicatorLayer.instanceDelay;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}

-(void)animationB
{
    double w=300, gap=(kMainScreen_Width-w)/2.0;
    
    _icon=[[UIImageView alloc] initWithFrame:CGRectMake(gap, 250, w, 200)];
    _icon.backgroundColor=[UIColor yellowColor];
    _icon.userInteractionEnabled=YES;
    [self.view addSubview:_icon];

    //贝塞尔曲线,以下是4个角的位置，相对于_icon
    CGPoint point1= CGPointMake(0, 80);
    CGPoint point2= CGPointMake(0, 200);
    CGPoint point3= CGPointMake(300, 200);
    CGPoint point4= CGPointMake(300, 80);
    
    _path=[UIBezierPath bezierPath];
    [_path moveToPoint:point1];//移动到某个点，也就是起始点
    [_path addLineToPoint:point2];
    [_path addLineToPoint:point3];
    [_path addLineToPoint:point4];
    [_path addQuadCurveToPoint:point1 controlPoint:CGPointMake(150, -30)];//controlPoint控制点，不等于曲线顶点
    
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.path=_path.CGPath;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;//填充颜色
    shapeLayer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    [_icon.layer addSublayer:shapeLayer];
    
    //动画
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = 3;
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
    pathAniamtion.autoreverses = NO;
    [shapeLayer addAnimation:pathAniamtion forKey:nil];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [_icon addGestureRecognizer:tap];
}

-(void)click:(UITapGestureRecognizer *)tap
{
    CGPoint point=[tap locationInView:_icon];
    if ([_path containsPoint:point]) {
        NSLog(@"点击不规则图形");
    }
}

@end
