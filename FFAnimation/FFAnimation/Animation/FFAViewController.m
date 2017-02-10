//
//  FFAViewController.m
//  FFAnimation
//
//  Created by 张玲玉 on 2017/2/9.
//  Copyright © 2017年 bj.zly.com. All rights reserved.
//

#import "FFAViewController.h"
#import "UIView+Extension.h"

@interface FFAViewController ()

@property (nonatomic,strong)UIImageView *icon;

@end

@implementation FFAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    double w=60, gap=(kMainScreen_Width-3*w)/4;
    NSArray *array=@[@"缩放",@"弹性",@"平移"];
    
    for (int i = 0; i<array.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(gap+(gap+w)*i, 120, w, 45);
        btn.tag=i;
        btn.backgroundColor=[UIColor orangeColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    _icon=[[UIImageView alloc] init];
    _icon.image=[UIImage imageNamed:@"Sparkle"];
    _icon.frame=CGRectMake((kMainScreen_Width-w)/2, 200, w, w);
    _icon.backgroundColor=[UIColor grayColor];
//    _icon.layer.masksToBounds=YES;
//    _icon.layer.cornerRadius=w/2.0;
    [self.view addSubview:_icon];
}

-(void)startAnimation:(UIButton *)btn
{
    _icon.transform=CGAffineTransformIdentity;
    
    switch (btn.tag) {
        case 0:
        {
            UIViewAnimationOptions options=UIViewAnimationOptionCurveEaseInOut;
            [UIView animateWithDuration:0 delay:0 options:options animations:^{
                [_icon.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:options animations:^{
                    [_icon.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.02 options:options animations:^{
                        [_icon.layer setValue:@(.9) forKeyPath:@"transform.scale"];
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.05 delay:0.02 options:options animations:^{
                            [_icon.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                            
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }];
        }
            break;
            
        case 1:
        {
            double centerX=_icon.centerX;
            _icon.centerX=centerX-50;
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _icon.centerX=centerX;

            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case 2:
        {
            double centerX=_icon.centerX;
            _icon.centerX=centerX-50;
            [UIView animateWithDuration:0.3 animations:^{
                 _icon.centerX=centerX;
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            break;
    }
}

@end
