//
//  XLLTabBarController.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/2.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLTabBarController.h"
#import "XLLNavigationController.h"
#import "XLLDialogController.h"
#import "XLLContactController.h"
#import "XLLUserController.h"
#import "UIImage+XLL.h"

@interface XLLTabBarController ()

@end

@implementation XLLTabBarController

// 第一次初始化的时候会走
+ (void)initialize
{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = XLLFont(12.0);
    normalAttrs[NSForegroundColorAttributeName] = XLLLightColor;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = RGB(18, 183, 245);
    //appearance会包含所有的UITabbarItem
    UITabBarItem *item = [UITabBarItem appearance];
    //appearanceWhenContainedInInstancesOfClasses表示本类包含的UItabbarItem
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //去除tabbar自带的边线
//    [self dropTabbarShadow];
    //添加自控制器
    [self addAllVCs];
}

- (void)dropTabbarShadow
{
    // 1.去除系统边线
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    // 2.增加阴影
    // 2.1设置阴影路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    // 2.2设置阴影颜色
    self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    // 2.3设置阴影偏移量
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -0.5);
    // 2.4设置阴影圆角
    self.tabBar.layer.shadowRadius = 0.5;
    // 2.5设置阴影透明度
    self.tabBar.layer.shadowOpacity = 0.5;
    self.tabBar.layer.masksToBounds = YES;
    // 3.取消半透明
    self.tabBar.translucent = NO;
}

- (void)addAllVCs
{
    [self setupChildVC:[[XLLDialogController alloc] init] title:@"聊天" normalImage:[UIImage imageWithColor:RGB(40, 40, 40)] selectedImage:[UIImage imageWithColor:RGB(35, 35, 35)]];
    [self setupChildVC:[[XLLContactController alloc] init] title:@"好友" normalImage:[UIImage imageWithColor:RGB(140, 140, 140)] selectedImage:[UIImage imageWithColor:RGB(135, 135, 135)]];
    [self setupChildVC:[[XLLUserController alloc] init] title:@"我" normalImage:[UIImage imageWithColor:RGB(240, 240, 240)] selectedImage:[UIImage imageWithColor:RGB(235, 235, 235)]];
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    XLLNavigationController *navigationVC = [[XLLNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navigationVC];
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
