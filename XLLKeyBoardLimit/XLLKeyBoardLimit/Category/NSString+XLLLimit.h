//
//  NSString+XLLLimit.h
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/13.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XLLLimit)

/**
 中文:按两个字符计算
 英文:按一个字符计算

 @return 字符长度
 */
- (NSInteger)xllDoubleLength;

/**
 中文:按一个字符计算
 英文:按半个字符计算

 @return 字符长度
 */
- (NSInteger)xllHalfLength;

/**
 是否包含表情

 @return 判断结果
 */
- (BOOL)stringContainsEmoji;

/**
 是否包含标点符号

 @return 判断结果
 */
- (BOOL)stringContainsSymbol;

@end
