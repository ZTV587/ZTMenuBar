//
//  Created by zZT on 15/4/28.
//  Copyright © 2015年 ZZT. All rights reserved.
//
#import "ZTViewController.h"
//要添加的标题
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
@interface ZTViewController ()

@end

@implementation ZTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //添加所有标题控制器
    [self addAllTitleViewControllers];

}

//添加所有子控制器
- (void)addAllTitleViewControllers {
    
    // 第一个
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    firstVc.title = @"第一个";
    [self addChildViewController:firstVc];
    
    // 第二个
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    secondVc.title = @"第二个";
    [self addChildViewController:secondVc];
    
    // 第三个
    ThirdViewController *thirdVc = [[ThirdViewController alloc] init];
    thirdVc.title = @"第三个";
    [self addChildViewController:thirdVc];
    
    FourthViewController *fourthVc = [[FourthViewController alloc] init];
    fourthVc.title = @"第四个";
    [self addChildViewController:fourthVc];
    
    FifthViewController *fifthVc = [[FifthViewController alloc] init];
    fifthVc.title = @"第五个";
    [self addChildViewController:fifthVc];
}
@end
