//
//  XLLPageCell.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLPageCell.h"

@implementation XLLPageCell

- (void)configCellWithVC:(UIViewController *)vc
{
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
}

@end
