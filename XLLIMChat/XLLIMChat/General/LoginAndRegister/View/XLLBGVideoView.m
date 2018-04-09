//
//  XLLBGVideoView.m
//  XLLIMChat
//
//  Created by 肖乐 on 2018/4/3.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBGVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface XLLBGVideoView ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, copy) NSString *videoPath;

@end

@implementation XLLBGVideoView

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
    [XLLNotificationCenter addObserver:self selector:@selector(playEndNotification) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    /**
     如果支持后台播放的话
     // 1.设置声道模式，告诉app支持后台播放
     AVAudioSession *audioSession = [AVAudioSession sharedInstance];
     [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
     [audioSession setActive:YES error:nil];
     // 2.在info.plist文件的Required background modes添加一个item，value为App plays audio or streams audio/video using AirPlay
     // 3.如果像酷狗音乐那样的话，在后台还能控制App。可以设置接收远程控制（下回了解）
     */
    [XLLNotificationCenter addObserver:self selector:@selector(DidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [XLLNotificationCenter addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"register_bg" ofType:@"mp4"];
    self.videoPath = videoPath;
    [self.player play];
}

#pragma mark - notification
- (void)DidEnterBackground
{
    [self.player pause];
}

- (void)willEnterForeground
{
    [self.player play];
}

- (void)playEndNotification
{
    [self.player seekToTime:kCMTimeZero];
}

#pragma mark - lazy loading
- (AVPlayerLayer *)playerLayer
{
    if (_playerLayer == nil)
    {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _playerLayer;
}

- (AVPlayer *)player
{
    if (_player == nil)
    {
        _player = [[AVPlayer alloc] initWithPlayerItem:[self getPlayerItem]];
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    }
    return _player;
}

- (AVPlayerItem *)getPlayerItem
{
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:self.videoPath]];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    return playerItem;
}

#pragma mark - setter方法
- (void)setVideoPath:(NSString *)videoPath
{
    _videoPath = [videoPath copy];
    
    [self.layer addSublayer:self.playerLayer];
}

- (void)startToPlay
{
    [self.player play];
}

- (void)stopPlay
{
    [self.player pause];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.playerLayer.frame = self.layer.bounds;
}

- (void)dealloc
{
    [XLLNotificationCenter removeObserver:self];
}

@end
