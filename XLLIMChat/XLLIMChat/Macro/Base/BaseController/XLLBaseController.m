//
//  XLLBaseController.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseController.h"
#import "UIViewController+Configuration.h"

@interface XLLBaseController ()

@end

@implementation XLLBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 渲染
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加返回按钮
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // 在此处理缓存的问题
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
