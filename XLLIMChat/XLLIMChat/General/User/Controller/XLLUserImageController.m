//
//  XLLUserImageController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUserImageController.h"

@interface XLLUserImageController () 

@end

@implementation XLLUserImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 25.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLLBaseCell *cell = [XLLBaseCell cell:tableView];
    cell.textLabel.text = XLLStr(@"当前为第%zd行", indexPath.row);
    cell.contentView.backgroundColor = RandomColor;
    return cell;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = XLLCGM(0, 0, self.view.width, self.view.height - 112);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
