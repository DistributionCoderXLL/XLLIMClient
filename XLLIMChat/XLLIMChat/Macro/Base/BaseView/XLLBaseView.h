//
//  XLLBaseView.h
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLBaseView : UIView

/**
 纯代码搭建view

 @return 返回view实例
 */
+ (instancetype)view;

/**
 xib搭建view

 @return 返回view实例
 */
+ (instancetype)xibView;

@end
