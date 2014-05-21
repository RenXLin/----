//
//  MainViewController.m
//  旋转移动
//
//  Created by renxlin on 14-3-29.
//  Copyright (c) 2014年 renxlin. All rights reserved.
//

#import "MainViewController.h"
#import "CoreAnimationEffect.h"
#import "SubViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()

@end

@implementation MainViewController
{
    UIView *view;
    UIView *view1;
    CGFloat angle;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 60, 60)];
    view1.backgroundColor= [UIColor blueColor];
    [self.view addSubview:view1];
    view = [[UIView alloc] initWithFrame:CGRectMake(60, 60, 60, 60)];
    view.backgroundColor = [UIColor redColor];
    [self.view.layer addSublayer:view.layer];
    angle = 10;
    [self startAnimate];
    
    
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(160, 200) radius:100 startAngle:3.14 endAngle:3.14 *3 clockwise:YES];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = aPath.CGPath;
//    animation.removedOnCompletion=NO;
//    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.autoreverses = NO;
    animation.duration = 0.1;
    animation.repeatCount = 100;
    [view.layer addAnimation:animation forKey:nil];
    
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 64+50, 300, 50);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 10;
    btn.tag = 1;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)btnClick
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:2.09];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cameraIrisHollowOpen"];
    [animation setSubtype:@"kCATransitionFromRight"];
    
    SubViewController *svc = [[SubViewController alloc] init];
    [self.view.layer addAnimation:animation forKey:nil];
//    [self.navigationController pushViewController:svc animated:YES];
    [self presentViewController:svc animated:YES completion:^{
    }];
}
-(void)startAnimate
{

    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 30;
//    rotationAnimation.removedOnCompletion = NO;
//    rotationAnimation.fillMode = kCAFillModeForwards;
    
    
    CABasicAnimation * moveAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
//    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    moveAnimation.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    moveAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(250, 300)];
    moveAnimation.byValue = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    moveAnimation.duration = 3;
//    moveAnimation.removedOnCompletion = NO;
//    moveAnimation.fillMode = kCAFillModeForwards;

    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 3.0f;
//    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    [CATransaction setCompletionBlock:^{
        NSLog(@"aaaaaaaa");
    }];
    //动画旋转中心点：
    [view1.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations =[NSArray arrayWithObjects:moveAnimation,rotationAnimation, nil];
    [view1.layer addAnimation:animationGroup forKey:@"animationGroup"];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
