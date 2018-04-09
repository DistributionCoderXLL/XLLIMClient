//
//  XLLSubPageController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLSubPageController.h"
#import "XLLUserImageController.h"
#import "XLLUserVideoController.h"

@interface XLLSubPageController ()

@end

@implementation XLLSubPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titleArray = @[@"我的图片", @"我的视频"];
    NSArray *classNames = @[[XLLUserImageController class], [XLLUserVideoController class]];
    [self reloadData:titleArray subViewDisplayClasses:classNames];
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
