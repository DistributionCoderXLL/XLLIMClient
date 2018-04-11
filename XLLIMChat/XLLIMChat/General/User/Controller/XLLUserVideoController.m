//
//  XLLUserVideoController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUserVideoController.h"
#import "XLLUserVideoModel.h"
#import "XLLUserVideoCell.h"
#import <XLLNetWorkEngine/XLLNetWorkEngine.h>

@interface XLLUserVideoController ()

@property (nonatomic, strong) NSMutableArray *videoArray;

@end

@implementation XLLUserVideoController

#pragma mark - lazy loading
- (NSMutableArray *)videoArray
{
    if (_videoArray == nil)
    {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [XLLNetWorkEngine getVideoListSuccess:^(id dataObject) {
        NSArray *videoArr = dataObject[@"VAP4BFR16"];
        self.videoArray = [XLLUserVideoModel mj_objectArrayWithKeyValuesArray:videoArr];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.width * 125 / 207.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLLUserVideoCell *cell = [XLLUserVideoCell xibCell:tableView];
    XLLUserVideoModel *videoModel = self.videoArray[indexPath.row];
    cell.videoModel = videoModel;
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
