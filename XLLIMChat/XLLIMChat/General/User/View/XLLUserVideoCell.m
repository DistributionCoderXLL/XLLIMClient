//
//  XLLUserVideoCell.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLUserVideoCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "XLLUserVideoModel.h"

@interface XLLUserVideoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *playView;

@end

@implementation XLLUserVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVideoModel:(XLLUserVideoModel *)videoModel
{
    _videoModel = videoModel;
    [self.coverView setImageWithURL:videoModel.cover.mj_url];
}

@end
