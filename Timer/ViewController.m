//
//  ViewController.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/15/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    NSTimer *timer;
    CircularDial *dial;
}
@property (nonatomic, strong) CircularLayer *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dial = [CircularDial new];
    dial.image = [UIImage imageNamed:@"hairy.jpg"];
}

- (void)viewDidLayoutSubviews {
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    if ([dial getTimeForTimeIndicator] >= dial.totalTime && [dial getTimeForTimeIndicator] > 0) {
        [dial pauseTimer];
    } else {
        if (dial.isPlaying) {
            [dial pauseTimer];
            [dial invalidateTimer];
        } else {
            [dial playTimer];
            float elapsedTime = [dial getTimeForTimeIndicator];
            [dial removeFromSuperview];
            if (elapsedTime > 0) {
                dial.totalTime = dial.totalTime - elapsedTime;
            } else {
                dial.totalTime = 10;
            }
            dial.frame = CGRectMake(100, 200, 200, 200);
            [dial setUpSubViews];
            [self.view addSubview:dial];
        }
    }
}
@end
