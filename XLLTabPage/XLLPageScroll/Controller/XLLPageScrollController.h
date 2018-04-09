//
//  XLLPageScrollController.h
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@protocol XLLPageScrollDelegate <NSObject>

@property (nonatomic, strong) UITableView *tableView;

@end

@interface XLLPageScrollController : UIViewController

/**
 刷新标题集合与class集合

 @param titleArray 标题集合
 @param classes class集合
 */
- (void)reloadData:(NSArray *)titleArray subViewDisplayClasses:(NSArray *)classes;

/**
 page滚动信号

 @return 信号
 */
- (RACSignal *)pageScrollSignal;

@end
