//
//  XLLTextConfig.h
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/16.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XLLTextFieldCharStyle) {
    
    XLLTextFieldCharStyleNormal = 1000, //无论是什么统一按1个字符
    XLLTextFieldCharStyleDouble,        //汉字2个字符，英文1个字符
    XLLTextFieldCharStyleHalf           //汉字1个字符，英文半个字符
};

@interface XLLTextConfig : NSObject

/**
 文本起始点距离textField左侧距离, 默认为5
 */
@property (nonatomic, assign) CGFloat leftMargin;

/**
 字符计算规则, 默认为XLLTextFieldCharStyleNormal
 */
@property (nonatomic, assign) XLLTextFieldCharStyle charStyle;

/**
 最大限制字符数, 默认为无限制
 */
@property (nonatomic, assign) NSInteger maxLimitCount;

/**
 占位文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat fontSize;

@end
