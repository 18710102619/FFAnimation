//
//  FFDViewController.m
//  FFAnimation
//
//  Created by 张玲玉 on 2017/2/9.
//  Copyright © 2017年 bj.zly.com. All rights reserved.
//

#import "FFDViewController.h"
#import "UIView+Extension.h"

#define kButton_Width 38

@interface FFDViewController ()

@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)UIButton *homeButton;

@end

@implementation FFDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame=CGRectMake(kMainScreen_Width-70, kMainScreen_Height-70, kButton_Width, kButton_Width);
    _btnArray=[NSMutableArray array];
    NSArray *array=@[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0 ; i < array.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=frame;
        btn.backgroundColor=[UIColor orangeColor];
        btn.layer.cornerRadius=kButton_Width/2.0;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [_btnArray addObject:btn];
    }
    
    _homeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _homeButton.frame=frame;
    [_homeButton setBackgroundImage:[UIImage imageNamed:@"chooser-button-tab"] forState:UIControlStateNormal];
    [_homeButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeButton];
}

- (void)startAnimation
{
    _homeButton.selected=!_homeButton.selected;
    if (_homeButton.selected) {
        [self showAnimation];
    }else{
        [self hiddenAnimation];
    }
}

-(void)showAnimation
{
    for (int  i = 0; i<_btnArray.count; i++) {
        UIButton *btn=_btnArray[i];
        
        CGPoint startPoint = _homeButton.center;
        CGPoint endPoint =CGPointMake(_homeButton.centerX, _homeButton.centerY-60*(_btnArray.count-i));

        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        btn.layer.position=endPoint;

        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(0);
        scaleAnimation.toValue = @(1);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)i);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    }
}

-(void)hiddenAnimation
{
    int index = 0;
    for (int  i = (int)_btnArray.count-1; i>=0; i--) {
        UIButton *btn=_btnArray[i];

        CGPoint startPoint = CGPointFromString([NSString stringWithFormat:@"%@",[btn.layer valueForKeyPath:@"position"]]);
        CGPoint endPoint =_homeButton.center;
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration=.3;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:startPoint];
        positionAnimation.toValue = [NSValue valueWithCGPoint:endPoint];
        positionAnimation.beginTime = CACurrentMediaTime() + (.3/(float)_btnArray.count * (float)index);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        [btn.layer addAnimation:positionAnimation forKey:@"positionAnimation"];

        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration=.3;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.fromValue = @(1);
        scaleAnimation.toValue = @(0);
        scaleAnimation.beginTime = CACurrentMediaTime() + (0.3/(float)_btnArray.count * (float)index);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        
        [btn.layer addAnimation:scaleAnimation forKey:@"transformscale"];
        btn.transform = CGAffineTransformMakeScale(1.f, 1.f);
        index++;
    }
}

@end
