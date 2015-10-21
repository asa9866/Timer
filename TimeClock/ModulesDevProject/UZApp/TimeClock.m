//
//  TimeClock.m
//  TimeClock
//
//  Created by sipo on 15/10/20.
//  Copyright (c) 2015年 bnu. All rights reserved.
//

#import "TimeClock.h"
#import "UZEngine/UZAppDelegate.h"
#import "UZEngine/NSDictionaryUtils.h"
#import <AVFoundation/AVFoundation.h>



@interface TimeClock(){
    NSInteger _cbId;
    NSTimer *timer;
    AVAudioPlayer *player;
    NSDictionary *dic;
}

@end

@implementation TimeClock

+ (void)launch {
    //在module.json里面配置的launchClassMethod，必须为类方法，引擎会在应用启动时调用配置的方法，模块可以在其中做一些初始化操作
}

- (id)initWithUZWebView:(UZWebView *)webView_ {
    if (self = [super initWithUZWebView:webView_]) {
        
    }
    return self;
}

- (void)dispose {
    //do clean
}

//开始定时
-(void)beginClock:(NSDictionary *)paramDict{
    _cbId = [paramDict integerValueForKey:@"cbId" defaultValue:-1];
    dic=paramDict;
    NSInteger n=[[dic stringValueForKey:@"delay" defaultValue:@"60"] integerValue];
    
    [self prepare:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:n target:self selector:@selector(play:) userInfo:nil repeats:NO];
    
    
    
}
//取消定时
-(void)cancelClock{
    [timer invalidate];
    timer = nil;
}

-(void)prepare:(NSTimer *)time{
    [timer invalidate];
    timer = nil;
    
    NSString *path = [dic stringValueForKey:@"path" defaultValue:nil];
    path=[self getPathWithUZSchemeURL:path];
    BOOL isRepeat=[[dic stringValueForKey:@"isRepeat" defaultValue:@"NO"] boolValue];
    [self prepareToPlayWithName:path isRepeat:isRepeat];
    
    //UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"标题" message:@"内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //[alert show];
}


//开始播放
-(void)prepareToPlayWithName:(NSString*)path isRepeat:(BOOL)flag{
    if ([player isPlaying]) {
        return;
    }
    AVAudioSession
    *session = [AVAudioSession
                
                sharedInstance];
    
    [session
     setActive:YES
     error:nil];
    
    
    [session
     setCategory:AVAudioSessionCategoryPlayback
     
     error:nil];
    //以及设置app支持接受远程控制事件代码。设置app支持接受远程控制事件，
    //其实就是在dock中可以显示应用程序图标，同时点击该图片时，打开app。
    //或者锁屏时，双击home键，屏幕上方出现应用程序播放控制按钮。
    
    [[UIApplication
      sharedApplication]
     beginReceivingRemoteControlEvents];
    //用下列代码播放音乐，测试后台播放
    
    
    // 创建播放器
    // NSString *string = [[NSBundle mainBundle] pathForResource:path ofType:type];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    
    player = [[AVAudioPlayer
               
               alloc]
              
              initWithContentsOfURL:url
              
              error:nil];
    [player
     prepareToPlay];
    [player
     setVolume:1];
    if (flag) {
        player.numberOfLoops= -1;//设置音乐播放次数  -1为一直循环
    }
    //    [player
    //     play];
    // [player p];
    //播放
    
}
-(void)play:(NSTimer *)time{
    [player
     play];
}

- (void)stop:(id)sender {
    [player stop];
    [timer invalidate];
    timer = nil;
    
}


//
//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    if (_cbId >= 0) {
//        NSDictionary *ret = @{@"index":@(buttonIndex+1)};
//        [self sendResultEventWithCallbackId:_cbId dataDict:ret errDict:nil doDelete:YES];
//    }
//}



@end
