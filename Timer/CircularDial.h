//
//  CircularDial.h
//  Timer
//
//  Created by Prajeet Shrestha on 7/16/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define kCircleRadius 70
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CircularDial : UIView
@property (nonatomic) UIView *blackAndWhiteImageContainer;
@property (nonatomic) UIView *colorImageContainer;
@property (nonatomic) UIImage *image;

- (void)setUpSubViews;
@end

#pragma mark CircularLayer
@interface CircularLayer : CALayer

@end

#pragma mark - EKLoader
@interface EkLoader: CALayer

@property (nonatomic, assign) float time;
@property (nonatomic) float totalTime;
@property (nonatomic) float alpha;

@end

