//
//  UIViewController+Configuration.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "UIViewController+Configuration.h"

@implementation UIViewController (Configuration)

//添加返回按钮
- (void)addBackButton
{
    if (self.navigationController.viewControllers.count <= 1) return;
    self.navigationItem.leftBarButtonItem = [self itemWithNormalImage:[UIImage imageNamed:@"XLL_Back_normal"] highImage:[UIImage imageNamed:@"XLL_Back_Highlighted"]];
}

- (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:normalImage];
    imageView.highlightedImage = highImage;
    CGRect imageViewF = imageView.frame;
    CGFloat scale = 2.0;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageViewF.size.width * scale, 38.0)];
    imageViewF.origin.y = (backView.frame.size.height - imageViewF.size.height) * 0.5;
    imageView.frame = imageViewF;
    [backView addSubview:imageView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(popLastViewController) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    return [[UIBarButtonItem alloc] initWithCustomView:backView];
}

- (void)popLastViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
