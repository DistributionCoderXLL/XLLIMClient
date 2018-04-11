//
//  XLLNetWorkParam.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLNetWorkParam.h"
#import "XLLUUIDString.h"
#import "NSString+OKASecure.h"

@implementation XLLNetWorkParam

+ (NSDictionary *)baseInfoDict
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[XLLUUIDString UUIDString] forKey:@"deviceSign"];
    return params;
}

// 拼接基本参数
+ (NSMutableDictionary *)transitParams:(NSDictionary *)params temURL:(NSString *)temURL
{
    //1.一个容错
    NSDictionary *currentParams = params;
    if (!params) {
        currentParams = [NSDictionary dictionary];
    }
    NSMutableDictionary *nParemeters = [NSMutableDictionary dictionary];
    if (params.allKeys.count > 0)
    {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseInfoDict]];
        [nParemeters setValuesForKeysWithDictionary:currentParams];
    } else {
        [nParemeters setValuesForKeysWithDictionary:[self baseInfoDict]];
    }
    NSArray *keys = [nParemeters allKeys];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       
        return [obj1 compare:obj2];
    }];
    //排完序之后，再拼接顺序的字典与key-value字符串
    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
    NSMutableString *strURL = [NSMutableString string];
    for (NSString *key in keys) {
        NSString *value = nParemeters[key];
        [paramsM setValue:value forKey:key];
        [strURL appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    if (keys.count > 0) {
        
        NSString *realStrURL = [strURL substringToIndex:strURL.length-1];
        // 2.使用密钥通过HMAC-SHA1算法签名字符基串，生成签名
        NSString* signature = [realStrURL hmacsha1];
        [nParemeters setValue:signature forKey:@"signature"];
    }
    return nParemeters;
}

@end
