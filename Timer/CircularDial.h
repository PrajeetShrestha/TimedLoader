//
//  CircularDial.h
//  Timer
//
//  Created by Prajeet Shrestha on 7/16/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "BorderLayer.h"
@class EkLoader;

@interface CircularDial : UIView
@property (nonatomic) UIView *blackAndWhiteImageContainer;
@property (nonatomic) UIView *colorImageContainer;
@property (nonatomic)  EkLoader *timeIndicator;
@property (nonatomic) UIImage *image;
@property (nonatomic) float totalTime;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isPaused;

- (void)setUpSubViews;
- (float)getTimeForTimeIndicator;
- (void)playTimer;
- (void)pauseTimer;
- (void)updateTime:(NSTimer *)timerPassed;
@end

#pragma mark CircularLayer
@interface CircularLayer : CALayer

- (id)initWithFrameHeight:(float)frameHeight;
@end

#pragma mark - EKLoader
@interface EkLoader: CALayer
@property (nonatomic) float frameHeight;
- (id)initWithFrameHeight:(float)frameHeight;

@property (nonatomic, assign) float time;
@property (nonatomic) float totalTime;

@end

