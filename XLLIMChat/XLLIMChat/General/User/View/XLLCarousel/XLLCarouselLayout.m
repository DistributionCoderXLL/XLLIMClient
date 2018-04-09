//
//  XLLCarouselLayout.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLCarouselLayout.h"

@implementation XLLCarouselLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(self.collectionView.width, self.collectionView.height);
    self.edgeSpacing = (self.collectionView.width = self.itemSize.width) * 0.5;
    self.itemSpacing = 0;
}

- (CGSize)collectionViewContentSize
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentWidth = self.edgeSpacing + self.itemSize.width * count + self.itemSpacing * (count - 1);
    return CGSizeMake(contentWidth, self.collectionView.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 1.首先当然要设置尺寸啦
    attrs.size = self.itemSize;
    // 2.设置当前indexPath cell的frame
    CGFloat x = self.edgeSpacing + indexPath.item * (self.itemSize.width + self.itemSpacing);
    CGFloat y = (self.collectionView.height - self.itemSize.height)*0.5;
    attrs.frame = XLLCGM(x, y, self.itemSize.width, self.itemSize.height);
    // 3.计算scale
    CGFloat contentOffsetCenterX = self.collectionView.contentOffset.x + self.collectionView.width * 0.5;
    CGFloat scale = 1 + 0.2 * (1 - ABS(x - contentOffsetCenterX) / (self.collectionView.width * 0.5));
    attrs.transform = CGAffineTransformMakeScale(scale, scale);
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++)
    {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        // 只添加可见的
        if (!CGRectIntersectsRect(attribute.frame, rect)) continue;
        [attributes addObject:attribute];
    }
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    return CGPointZero;
}

@end
