//
//  XLLBaseCell.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseCell.h"

@implementation XLLBaseCell

// 纯代码返回cell
+ (instancetype)cell:(UITableView *)tableView
{
    NSString *ID = NSStringFromClass(self.class);
    XLLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        // 注册
        [tableView registerClass:self forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

// xib返回cell
+ (instancetype)xibCell:(UITableView *)tableView
{
    NSString *ID = NSStringFromClass(self.class);
    XLLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}

// 返回一个空白cell
+ (instancetype)blankCell:(UITableView *)tableView
{
    static NSString *const ID = @"XLLBlankCell";
    XLLBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[XLLBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

@end
