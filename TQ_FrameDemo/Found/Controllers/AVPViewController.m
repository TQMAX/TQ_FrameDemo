//
//  AVPViewController.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2017/12/28.
//  Copyright © 2017年 TQ_Lemon. All rights reserved.
//

#import "AVPViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (strong, nonatomic)  UIView *containerView;
@property (strong, nonatomic)  UIButton *palyPause;
@property (strong, nonatomic)  UIProgressView *progress;

@end

@implementation AVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:self.containerView];
    //1.创建网络视频路径
    NSString *urlStr = @"http://www.baidu.com";
//    NSString *urlStr = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    //urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//url只支持英文和少数其它字符，因此对url中非标准字符需要进行编码，这个编码方*****能不完善，因此使用下面的方法编码。
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *netUrl = [NSURL URLWithString:urlStr];
//    //2.创建AVPlayer
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:netUrl];
//    _avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
////    _avPlayer.currentItem;//用于获取当前的AVPlayerItem
//    //3.设置每秒执行一次进度更新
//    UIProgressView *progressView = _progress;//
//    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        float current = CMTimeGetSeconds(time);
//        float total = CMTimeGetSeconds([playerItem duration]);
//        if (current) {
//            progressView.progress = current / total;
//        }
//    }];
//    //4.监控播放状态,KVO
//    [_avPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];//监控状态属性，获取播放状态。
//    [_avPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];//监控网络加载情况
//    //5.创建播放层，开始播放视频
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
//    playerLayer.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//视频填充模式
//    [_containerView.layer addSublayer:playerLayer];
//    [_avPlayer play];
//    //7.添加播放完成通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayer.currentItem];
    
    UIWebView *myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 48)];
    [myWeb setDelegate:self];
    NSURLRequest *req = [NSURLRequest requestWithURL:netUrl];
    [myWeb loadRequest:req];
    [self.view addSubview:myWeb];

}

//视频播放完成
-(void)playbackFinish:(NSNotification *)notification{
    NSLog(@"视频播放完成");
}

//通过KVO监控播放器的状态
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"正在播放:%.2f", CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f", totalBuffer);
    }
}

-(void)dealloc{
    [_avPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    [_avPlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)playPause:(id)sender {
    if (_avPlayer.rate == 0) {//暂停
        [_avPlayer play];
    }else if(_avPlayer.rate == 1){//正在播放
        [_avPlayer pause];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
