//
//  XLLTextConfig.m
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/16.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLTextConfig.h"

@implementation XLLTextConfig

- (instancetype)init
{
    if (self = [super init])
    {
        //配置默认值
        [self setupDefaultProperties];
    }
    return self;
}

//配置默认值
- (void)setupDefaultProperties
{
    self.leftMargin = 5.0;
    self.charStyle = XLLTextFieldCharStyleNormal;
    self.maxLimitCount = NSIntegerMax;
    self.placeholder = @"欢迎使用";
    self.fontSize = 13.0;
}

@end
