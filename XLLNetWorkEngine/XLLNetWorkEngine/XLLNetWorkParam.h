//
//  XLLNetWorkParam.h
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLNetWorkParam : NSObject

/**
 拼接基本参数

 @param params 对应接口的参数字典
 @param temURL 请求路径
 @return 完整参数
 */
+ (NSMutableDictionary *)transitParams:(NSDictionary *)params temURL:(NSString *)temURL;

@end
