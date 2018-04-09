//
//  XLLPageScrollView.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/8.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLPageScrollView.h"

@interface XLLPageScrollView ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation XLLPageScrollView

- (instancetype)init
{
    if (self = [super init])
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"login_bg"];
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

- (void)layoutSubviews
{
//    self.imageView.frame = XLLCGM(0, 0, self.width, 100);
}

@end
