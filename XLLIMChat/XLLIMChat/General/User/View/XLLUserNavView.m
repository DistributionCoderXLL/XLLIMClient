//
//  XLLUserNavView.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUserNavView.h"

@interface XLLUserNavView ()

@property (nonatomic, weak) XLLBaseView *bgView;
@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation XLLUserNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupBase];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupBase];
    }
    return self;
}

- (void)setupBase
{
    self.backgroundColor = [UIColor clearColor];
    XLLBaseView *bgView = [XLLBaseView view];
    bgView.alpha = 0;
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"总 结";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = XLLFont(17.0);
    titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)setBgAlpha:(CGFloat)bgAlpha
{
    self.titleLabel.textColor = bgAlpha <= 0?[UIColor whiteColor]:[UIColor orangeColor];
    self.bgView.backgroundColor = bgAlpha <= 0?[UIColor clearColor]:[UIColor redColor];
    self.bgView.alpha = bgAlpha;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    self.titleLabel.frame = XLLCGM((self.width - 70)/2.0, (self.height - 20 - 25)/2.0 + 20, 70, 25);
}

@end
