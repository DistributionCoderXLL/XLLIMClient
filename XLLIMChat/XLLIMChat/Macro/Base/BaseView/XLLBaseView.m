//
//  XLLBaseView.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseView.h"

@implementation XLLBaseView

+ (instancetype)view
{
    return [[XLLBaseView alloc] init];
}

+ (instancetype)xibView
{
    NSString *nibName = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:nibName owner:nibName options:nil];
    for (UIView *view in views) {
        if ([view isKindOfClass:NSClassFromString(nibName)]) {
            return (XLLBaseView *)view;
        }
    }
    return nil;
}

@end
