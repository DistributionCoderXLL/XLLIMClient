//
//  XLLBaseCell.h
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLBaseCell : UITableViewCell

/**
 返回一个纯代码编写的cell实例

 @param tableView 承载cell的tableView
 @return cell实例
 */
+ (instancetype)cell:(UITableView *)tableView;

/**
 返回一个xib编写的cell实例

 @param tableView 承载cell的tableView
 @return cell实例
 */
+ (instancetype)xibCell:(UITableView *)tableView;

/**
 返回一个空白的cell实例

 @param tableView 承载cell的tableView
 @return cell实例
 */
+ (instancetype)blankCell:(UITableView *)tableView;

@end
