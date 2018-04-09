//
//  NSString+XLL.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/2.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "NSString+XLL.h"

@implementation NSString (XLL)

- (UIColor*)rgbColor
{
    if (self.length == 6)
    {
        
        NSInteger red = strtol([self substringWithRange:NSMakeRange(0, 2)].UTF8String, NULL, 16);
        NSInteger green = strtol([self substringWithRange:NSMakeRange(2, 2)].UTF8String, NULL, 16);
        NSInteger blue = strtol([self substringWithRange:NSMakeRange(4, 2)].UTF8String, NULL, 16);
        return RGB(red, green, blue);
    }
    return [UIColor clearColor];
}

@end
