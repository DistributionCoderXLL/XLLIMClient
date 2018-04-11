//
//  XLLUserVideoModel.h
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseModel.h"

@interface XLLUserVideoModel : XLLBaseModel

/**
 视频地址
 */
@property (nonatomic, copy) NSString *mp4_url;

/**
 视频占位图地址
 */
@property (nonatomic, strong) NSString *cover;

@end
