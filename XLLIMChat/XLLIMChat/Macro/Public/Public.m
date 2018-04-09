//
//  Public.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/2.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "Public.h"

@implementation Public

//App名称
+ (NSString *)appName
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return appName;
}

//版本号
+ (NSString *)appVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

//build号
+ (NSString *)appBuild
{
    NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return appBuild;
}

//收回键盘
+ (void)hideKeyboard
{
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    UIWindow *keyWindow = [[UIApplicationClass performSelector:@selector(sharedApplication)] valueForKey:@"keyWindow"];
    [keyWindow endEditing:YES];
}

@end
