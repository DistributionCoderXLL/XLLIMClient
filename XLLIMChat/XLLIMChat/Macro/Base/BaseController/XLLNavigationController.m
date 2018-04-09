//
//  XLLNavigationController.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/2.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLNavigationController.h"
#import "UIImage+XLL.h"

@interface XLLNavigationController ()

@end

@implementation XLLNavigationController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    //取消半透明
    navigationBar.translucent = NO;
    navigationBar.barTintColor = [UIColor redColor];
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor blackColor]]];
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = XLLFont(17.0);
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:attrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
