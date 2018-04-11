//
//  XLLUUIDString.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUUIDString.h"
#import "NSString+OKASecure.h"

#define UUIDSTOREKEYFORNONMEMEBER @"UUIDSTOREKEYFORNONMEMEBER"
#define KisEncrypt @"KisEncrypt"
#define THREE_DESKEY @"2b504aadcc87a325fe190566"

@implementation XLLUUIDString

+ (NSString *)UUIDString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uuidString = [userDefaults stringForKey:UUIDSTOREKEYFORNONMEMEBER];
    NSString *isEncrypt = [userDefaults stringForKey:[NSString stringWithFormat:@"%@_%@", UUIDSTOREKEYFORNONMEMEBER, KisEncrypt]];
    if ((isEncrypt && [isEncrypt isEqualToString:@"Y"]) && uuidString) {
        return uuidString;
    }
    NSString *uuid = [NSString stringWithFormat:@"%f_%@", [NSDate date].timeIntervalSince1970, [NSUUID UUID].UUIDString];
    uuidString = [uuid oka_stringEncryptIn3DesWithKey:THREE_DESKEY];
    if (!uuidString) {
        uuidString = uuid;
    }
    // 存
    [userDefaults setValue:!uuidString?@"":uuidString forKey:UUIDSTOREKEYFORNONMEMEBER];
    [userDefaults setValue:@"Y" forKey:[NSString stringWithFormat:@"%@_%@", UUIDSTOREKEYFORNONMEMEBER, KisEncrypt]];
    [userDefaults synchronize];
    return uuidString;
}

@end
