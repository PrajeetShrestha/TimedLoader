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
    // CircularDial *dial;
}


@end

@implementation ViewController
@synthesize dial;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    if ([dial getTimeForTimeIndicator] >= dial.totalTime && [dial getTimeForTimeIndicator] > 0) {
        dial.timeIndicator.time = 0;
        [dial playTimer];
    } else {
        if (dial.isPlaying) {
            [dial pauseTimer];
        } else {
            [dial playTimer];
            float elapsedTime = [dial getTimeForTimeIndicator];
            [self reinitiateDialWithElapsedTime:elapsedTime];
        }
    }
}

- (void)reinitiateDialWithElapsedTime:(float)elapsedTime {
    if (elapsedTime == 0) {
        dial.totalTime = 10;
        dial.image = [UIImage imageNamed:@"hairy.jpg"];
        [dial setUpSubViews];
    } else {
        dial.timeIndicator.time = elapsedTime;
    }
    [self.view addSubview:dial];
}
@end
