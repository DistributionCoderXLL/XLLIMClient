//
//  XLLBaseLoginController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseLoginController.h"

@interface XLLBaseLoginController ()

@end

@implementation XLLBaseLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:[UIScrollView class]])
            {
                UIScrollView *scrollView = (UIScrollView *)subView;
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                break;
            }
        }
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.navigationController.navigationBar.translucent = YES;
    NSDictionary *textAttrs = @{
                                NSFontAttributeName:XLLFont(17.0),
                                NSForegroundColorAttributeName:RGB(255, 188, 56)
                                };
    self.navigationController.navigationBar.titleTextAttributes = textAttrs;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
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
