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
    __weak IBOutlet UIView *containerView;
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
    dial.frame = CGRectMake(0, 0, 170, 170);
    [dial setUpSubViews];
    [self.view addSubview:dial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
