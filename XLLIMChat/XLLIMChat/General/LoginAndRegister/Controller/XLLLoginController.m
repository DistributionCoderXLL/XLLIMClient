//
//  XLLLoginController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLLoginController.h"
#import "XLLBGVideoView.h"
#import "XLLTabBarController.h"

@interface XLLLoginController ()

@property (weak, nonatomic) IBOutlet XLLBGVideoView *videoView;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation XLLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.videoView startToPlay];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.videoView stopPlay];
}

- (IBAction)loginBtnClick:(id)sender {
    
    XLLTabBarController *tabVC = [[XLLTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
    /**
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.accountField.text password:self.passwordField.text];
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    XLLLog(@"%lf秒", endTime - startTime);
    if (error) {
        XLLLog(@"%@", error.errorDescription);
    }
     */
}

- (IBAction)registerBtnClick:(id)sender {
    
    
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
