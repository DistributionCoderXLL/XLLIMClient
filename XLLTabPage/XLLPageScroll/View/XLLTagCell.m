//
//  XLLTagCell.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLTagCell.h"

@interface XLLTagCell ()

@property (nonatomic, weak) UILabel *tagLabel;

@end

@implementation XLLTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupBase];
    }
    return self;
}

- (void)setupBase
{
    UILabel *tagLabel = [[UILabel alloc] init];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.textColor = [UIColor grayColor];
    tagLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:tagLabel];
    self.tagLabel = tagLabel;
}

- (void)setTagStr:(NSString *)tagStr
{
    _tagStr = [tagStr copy];
    self.tagLabel.text = tagStr;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.tagLabel.textColor = selected?[UIColor brownColor]:[UIColor grayColor];
    self.tagLabel.font = selected?[UIFont systemFontOfSize:16.0]:[UIFont systemFontOfSize:15.0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tagLabel.frame = self.contentView.bounds;
}

@end
