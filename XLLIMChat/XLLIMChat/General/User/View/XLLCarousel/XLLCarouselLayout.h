//
//  XLLCarouselLayout.h
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLCarouselLayout : UICollectionViewLayout

// 每个item尺寸
@property (nonatomic, assign) CGSize itemSize;
// 每个item之间的间距
@property (nonatomic, assign) CGFloat itemSpacing;
// 边缘间距
@property (nonatomic, assign) CGFloat edgeSpacing;

@end
