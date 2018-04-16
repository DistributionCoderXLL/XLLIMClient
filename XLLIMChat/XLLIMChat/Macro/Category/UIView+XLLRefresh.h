//
//  UIView+XLLRefresh.h
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/12.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLRefreshView : UIScrollView

@end

@interface UIView (XLLRefresh)

/**
 开始下拉刷新

 @param scrollView 刷新的scrollView
 @param refreshBlock 刷新回调
 */
- (void)refreshWithScrollView:(UIScrollView *)scrollView refreshBlock:(void(^)(void))refreshBlock;

- (void)endXLLRefresh;

@end

