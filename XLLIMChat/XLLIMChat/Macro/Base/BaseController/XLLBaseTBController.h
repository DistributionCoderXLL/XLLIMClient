//
//  XLLBaseTBController.h
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseController.h"

@interface XLLBaseTBController : XLLBaseController <UITableViewDelegate, UITableViewDataSource>

/**
 修改的话，必须在[super viewdidLoad]前
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/**
 tableView
 */
@property (nonatomic, weak, readonly) UITableView *tableView;

@end
