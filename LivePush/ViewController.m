//
//  ViewController.m
//  LivePush
//
//  Created by 成杰 on 16/6/16.
//  Copyright © 2016年 ztgame.com. All rights reserved.
//

#import "ViewController.h"
#import "VCSimpleSession.h"

@interface ViewController () <VCSessionDelegate>

@property (nonatomic, strong) VCSimpleSession *session;
@property (nonatomic, strong) UIButton *button;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [self.view bounds].size.width;
    CGFloat hight = [self.view bounds].size.height;
    CGSize size = CGSizeMake(width, hight);
    CGRect rect = CGRectMake(0, 0, width, hight);
    self.session = [[VCSimpleSession alloc] initWithVideoSize:size frameRate:30 bitrate:1000000 useInterfaceOrientation:NO];
    _session.orientationLocked = YES;
    _session.delegate = self;
    _session.previewView.frame = rect;
    [self.view addSubview:_session.previewView];
    
    CGFloat btnW = 100;
    CGFloat btnH = 40;
    CGFloat btnX = [self.view bounds].size.width/2 - btnW/2;
    CGFloat btnY = [self.view bounds].size.height - btnH;
    CGRect btnFrame = CGRectMake(btnX, btnY, btnW, btnH);
    self.button = [[UIButton alloc] initWithFrame:btnFrame];
    [_button setBackgroundColor:[UIColor greenColor]];
    [_button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)btnClicked {
    
    switch(_session.rtmpSessionState) {
        case VCSessionStateNone:
        case VCSessionStatePreviewStarted:
        case VCSessionStateEnded:
        case VCSessionStateError:
            [_session startRtmpSessionWithURL:@"rtmp://192.168.1.107/live" andStreamKey:@"livestream"];
            break;
        default:
            [_session endRtmpSession];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// pargma mark: - VCSessionDelegate
- (void)connectionStatusChanged:(VCSessionState)state {
    switch(state) {
        case VCSessionStateStarting:
            [self.button setTitle:@"Connecting" forState:UIControlStateNormal];
            break;
        case VCSessionStateStarted:
            [self.button setTitle:@"Disconnect" forState:UIControlStateNormal];
            break;
        default:
            [self.button setTitle:@"Connect" forState:UIControlStateNormal];
            break;
    }
}

@end
