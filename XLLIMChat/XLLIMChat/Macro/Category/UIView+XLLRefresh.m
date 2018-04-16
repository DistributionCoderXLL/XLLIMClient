//
//  UIView+XLLRefresh.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/12.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "UIView+XLLRefresh.h"
#import <objc/runtime.h>

@interface XLLRefreshView ()

//刷新view的icon
@property (nonatomic, strong) UIImageView *refreshIcon;

- (void)beginAnimation;
- (void)endAnimation;

@end

@implementation XLLRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentSize = frame.size;
        self.clipsToBounds = NO;
        self.bounces = NO;
        [self setupBase];
    }
    return self;
}

- (void)setupBase
{
    self.refreshIcon = [[UIImageView alloc] initWithFrame:self.bounds];
    self.refreshIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.refreshIcon.image = [[UIImage imageNamed:@"refresh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.refreshIcon.clipsToBounds = YES;
    self.refreshIcon.layer.cornerRadius = self.frame.size.width * 0.5;
    self.refreshIcon.alpha = 0;
    [self addSubview:self.refreshIcon];
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    self.refreshIcon.alpha = -contentOffset.y / 25.0;
}

- (void)beginAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 0.8;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.refreshIcon.layer addAnimation:animation forKey:@"rotation"];
}

- (void)endAnimation
{
    if ([self.refreshIcon.layer valueForKey:@"rotation"])
    {
        [self.refreshIcon.layer removeAnimationForKey:@"rotation"];
    }
}

@end

typedef NS_ENUM(NSInteger, XLLRefreshStatus) {
    XLLRefreshStatusNormal = 1000,  //没刷新
    XLLRefreshStatusRefresh         //刷新
};


@interface UIView ()

//下拉动画
@property (nonatomic, strong) CABasicAnimation *animation;
//用于刷新回调
@property (nonatomic, copy) void(^refreshBlock)(void);
//作用的UIScrollView
@property (nonatomic, strong) UIScrollView *refreshScrollView;
//刷新view
@property (nonatomic, strong) XLLRefreshView *refreshView;
//刷新状态
@property (nonatomic, assign) XLLRefreshStatus refreshStatus;

@end

@implementation UIView (XLLRefresh)

#pragma mark - setter, getter
- (void)setAnimation:(CABasicAnimation *)animation
{
    objc_setAssociatedObject(self, @selector(animation), animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CABasicAnimation *)animation
{
    return objc_getAssociatedObject(self, @selector(animation));
}

- (void)setRefreshBlock:(void (^)(void))refreshBlock
{
    objc_setAssociatedObject(self, @selector(refreshBlock), refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))refreshBlock
{
    return objc_getAssociatedObject(self, @selector(refreshBlock));
}

- (void)setRefreshScrollView:(UIScrollView *)refreshScrollView
{
    objc_setAssociatedObject(self, @selector(refreshScrollView), refreshScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)refreshScrollView
{
    return objc_getAssociatedObject(self, @selector(refreshScrollView));
}

- (void)setRefreshView:(XLLRefreshView *)refreshView
{
    objc_setAssociatedObject(self, @selector(refreshView), refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XLLRefreshView *)refreshView
{
    return objc_getAssociatedObject(self, @selector(refreshView));
}

- (void)setRefreshStatus:(XLLRefreshStatus)refreshStatus
{
    objc_setAssociatedObject(self, @selector(refreshStatus), [NSNumber numberWithInteger:refreshStatus], OBJC_ASSOCIATION_RETAIN);
}

- (XLLRefreshStatus)refreshStatus
{
    return [objc_getAssociatedObject(self, @selector(refreshStatus)) integerValue];
}

//开始刷新
- (void)refreshWithScrollView:(UIScrollView *)scrollView refreshBlock:(void (^)(void))refreshBlock
{
    self.refreshScrollView = scrollView;
    self.refreshBlock = refreshBlock;
    self.refreshStatus = XLLRefreshStatusNormal;
    // 让view监听scrollView的滚动
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    if (!self.refreshView)
    {
        self.refreshView = [[XLLRefreshView alloc] initWithFrame:CGRectMake(10, self.frame.origin.y + 64 - 40, 40, 40)];
        [self addSubview:self.refreshView];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offset = self.refreshScrollView.contentOffset.y;
    if (self.refreshStatus == XLLRefreshStatusNormal) {
        
        [self defaultHandleWithOffsetY:offset change:change];
    }
}

// 非刷新时处理
- (void)defaultHandleWithOffsetY:(CGFloat)offsetY change:(NSDictionary <NSKeyValueChangeKey, id>*)change
{
    if (offsetY >= -60 && offsetY < 0)
    {
        [self.refreshView setContentOffset:CGPointMake(0, offsetY)];
        CGPoint newPoint;
        id newValue = [change valueForKey:NSKeyValueChangeNewKey];
        [(NSValue *)newValue getValue:&newPoint];
        if (self.refreshView.center.y < newPoint.y)
        {
            self.refreshView.refreshIcon.transform = CGAffineTransformRotate(self.refreshView.refreshIcon.transform, -0.2);
        } else if (self.refreshView.center.y > newPoint.y) {
            self.refreshView.refreshIcon.transform = CGAffineTransformRotate(self.refreshView.refreshIcon.transform, 0.2);
        }
    }
    if (offsetY <= -60)
    {
        if (self.refreshStatus != XLLRefreshStatusRefresh)
        {
            self.refreshStatus = XLLRefreshStatusRefresh;
            [self.refreshView beginAnimation];
            if (self.refreshBlock) {
                self.refreshBlock();
            }
        }
    }
}

- (void)endXLLRefresh
{
    if (self.refreshBlock)
    self.refreshStatus = XLLRefreshStatusNormal;
    [self.refreshView endAnimation];
    [self.refreshView setContentOffset:CGPointZero animated:YES];
}

@end
