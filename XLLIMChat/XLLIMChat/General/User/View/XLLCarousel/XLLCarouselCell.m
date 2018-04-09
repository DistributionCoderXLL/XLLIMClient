//
//  XLLCarouselCell.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/4.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLCarouselCell.h"

@interface XLLCarouselCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation XLLCarouselCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.iconView.image = image;
}

@end
