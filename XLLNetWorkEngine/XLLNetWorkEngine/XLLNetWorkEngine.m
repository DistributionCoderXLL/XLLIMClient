//
//  XLLNetWorkEngine.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLNetWorkEngine.h"

@implementation XLLNetWorkEngine

+ (void)getVideoListSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self GETWithPath:@"nc/video/list/VAP4BFR16/y/0-10.html" params:nil progress:nil success:success failure:failure];
}

@end
