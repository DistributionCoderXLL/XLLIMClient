//
//  XLLBaseModel.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseModel.h"

@implementation XLLBaseModel

+ (instancetype)model
{
    return [[[self class] alloc] init];
}

// 遵守NSCoding协议，快速归解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [self mj_decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self mj_encode:aCoder];
}

// 对不合法的属性进行替换
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"_id",
             @"v":@"__v"
             };
}

@end
