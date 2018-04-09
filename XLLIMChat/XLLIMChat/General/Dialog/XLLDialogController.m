//
//  XLLUserController.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLDialogController.h"
#import "XLLDragCollectionView.h"

@interface XLLDialogController () <XLLDragCollectionViewDelegate, XLLDragCollectionViewDataSource>

@property (nonatomic, weak) XLLDragCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XLLDialogController

#pragma mark - lazy loading
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < 15; i++)
        {
            [arr addObject:XLLStr(@"%zd", i)];
        }
        _dataArray = arr;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XLLLog(@"%@", kNetWorkServiceAddress);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake(80, 80);
    XLLDragCollectionView *collectionView = [[XLLDragCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - XLLDragCollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSArray *)dataSourceOfCollectionView:(XLLDragCollectionView *)collectionView
{
    return self.dataArray;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.frame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = self.dataArray[indexPath.item];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = XLLFont(15.0);
    [cell.contentView addSubview:label];
    cell.contentView.backgroundColor = RandomColor;
    return cell;
}

#pragma mark - XLLDragCollectionViewDelegate
- (void)collectionView:(XLLDragCollectionView *)collectionView newDataSourceAfterMove:(NSArray *)newDataSource
{
    self.dataArray = [newDataSource mutableCopy];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
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
