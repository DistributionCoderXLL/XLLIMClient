//
//  UIImage+XLL.h
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLL)

/**
 将颜色转成UIImage

 @param color 颜色
 @return UIImage实例
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
