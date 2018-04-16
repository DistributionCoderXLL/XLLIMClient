//
//  UITextField+XLLLimit.h
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/13.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//  字符限制textField

#import <UIKit/UIKit.h>
#import "XLLTextConfig.h"

@interface UITextField (XLLLimit)

@property (nonatomic, strong) XLLTextConfig *fieldConfig;
//是否达到了字符最大限制
@property (nonatomic, assign) BOOL isGetMaxLimit;

@end
