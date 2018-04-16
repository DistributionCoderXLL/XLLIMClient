//
//  NSString+XLLLimit.m
//  XLLKeyBoardInputLimit
//
//  Created by 肖乐 on 2018/4/13.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "NSString+XLLLimit.h"

@implementation NSString (XLLLimit)
//九宫格的特殊处理
static NSString *const XLLSpeedDialSTR = @"➋➌➍➎➏➐➑➒";
static NSString *const XLLSymbolSTR = @"~!@#$%^&*()_+-=,./;'\[]<>?:\"|{}，。／；‘、［］《》？：“｜｛｝／＊－＋＝——）（&…％¥＃@！～";

//中文:2个字符 英文:1个字符
- (NSInteger)xllDoubleLength
{
    NSInteger strLength = 0;
    //gbk编码
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //c语言循环char *字符串(这里gbk编码将汉字拆分成2个字符)
    char *p = (char *)[self cStringUsingEncoding:gbkEncoding];
    for (NSUInteger i = 0; i < [self lengthOfBytesUsingEncoding:gbkEncoding]; i++)
    {
        if (p)
        {
            p++;
            strLength++;
        } else {
            p++;
        }
    }
    return strLength;
}

//中文:1个字符 英文:半个字符
- (NSInteger)xllHalfLength
{
    //8->4 7->4 6->3
    NSInteger strLength = [self xllDoubleLength];
    return strLength/2 + strLength%2;
}

//是否为表情
- (BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;
    // 不知道是什么原因,九宫格的时候,输入的是表情.但是其实是正常的输入.
    if ([XLLSpeedDialSTR rangeOfString:self].length > 0) {
        return NO;
    }
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

//禁止输入标点符号
- (BOOL)stringContainsSymbol
{
    return [XLLSymbolSTR rangeOfString:self].length > 0;
}


@end
