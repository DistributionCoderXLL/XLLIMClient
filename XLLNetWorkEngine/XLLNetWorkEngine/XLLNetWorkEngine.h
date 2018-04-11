//
//  XLLNetWorkEngine.h
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseNetWorkEngine.h"

@interface XLLNetWorkEngine : XLLBaseNetWorkEngine

/**
 获取视频列表

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getVideoListSuccess:(void(^)(id dataObject))success
                    failure:(void(^)(NSError *error))failure;

@end
