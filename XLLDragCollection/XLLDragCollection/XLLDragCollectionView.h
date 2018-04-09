//
//  XLLDragCollectionView.h
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/9.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//  cell拖动九宫格

#import <UIKit/UIKit.h>

@class XLLDragCollectionView;
@protocol XLLDragCollectionViewDataSource <UICollectionViewDataSource>

@required
- (NSArray *)dataSourceOfCollectionView:(XLLDragCollectionView *)collectionView;

@end

@protocol XLLDragCollectionViewDelegate <UICollectionViewDelegate>

@required
- (void)collectionView:(XLLDragCollectionView *)collectionView newDataSourceAfterMove:(NSArray *)newDataSource;

@end

@interface XLLDragCollectionView : UICollectionView

/**
 数据源代理
 */
@property (nonatomic, weak) id <XLLDragCollectionViewDataSource> dataSource;

/**
 回调代理
 */
@property (nonatomic, weak) id <XLLDragCollectionViewDelegate> delegate;

@end
