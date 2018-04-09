//
//  XLLBaseTBController.m
//  XLLBaseProject
//
//  Created by 肖乐 on 2018/3/30.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseTBController.h"

@interface XLLBaseTBController ()

@property (nonatomic, weak, readwrite) UITableView *tableView;

@end

@implementation XLLBaseTBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    tableView.delegate = self;
    tableView.dataSource = self;
//    self.tableView.estimatedRowHeight = 0;
//    self.tableView.estimatedSectionFooterHeight = 0;
//    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.height - tableView.contentInset.top - tableView.contentInset.bottom;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLLBaseCell *cell = [XLLBaseCell blankCell:tableView];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = NSStringFromClass(self.class);
    return cell;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = XLLCGM(0, 0, self.view.width, self.view.height - 50);
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
