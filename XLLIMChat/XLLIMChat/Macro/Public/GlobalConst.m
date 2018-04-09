//
//  GlobalConst.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "GlobalConst.h"

#if DEVELOPMENT

NSString *const kNetWorkServiceAddress = @"https://xiaolele/api";

#else

NSString *const kNetWorkServiceAddress = @"https://t-xiaolele/api";

#endif

/** 子控制器滚动通知 */
NSNotificationName const XLLSubScrollNotification = @"XLLSubScrollNotification";

@implementation GlobalConst

@end
