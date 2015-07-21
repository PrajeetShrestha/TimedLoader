//
//  ViewController.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/15/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ImageEffects.h"


@interface ViewController () {
    NSTimer *timer;
    // CircularDial *dial;
}
@end

@implementation ViewController
@synthesize dial;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *caputuredImage = [UIImage new];
    caputuredImage = [UIImage imageNamed:@"hairy.jpg"];
    caputuredImage = [self grayishImage:caputuredImage];
    caputuredImage = [self blurWithImageEffects:caputuredImage];
    self.image .image = caputuredImage;
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
        dial.totalTime = 30;
        // Set the time in seconds
        dial.image = [UIImage imageNamed:@"hairy.jpg"];
        [dial setUpSubViews];
    } else {
        dial.timeIndicator.time = elapsedTime;
    }
    [self.view addSubview:dial];
}

- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


- (UIImage *)blurWithImageEffects:(UIImage *)image
{
    return [image applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:100 alpha:0.2] saturationDeltaFactor:1.5 maskImage:nil];
}

- (UIImage*) grayishImage: (UIImage*) inputImage {
    // Create a graphic context.
    UIGraphicsBeginImageContextWithOptions(inputImage.size, YES, 1.0);
    CGRect imageRect = CGRectMake(0, 0, inputImage.size.width, inputImage.size.height);
    // Draw the image with the luminosity blend mode.
    // On top of a white background, this will give a black and white image.
    [inputImage drawInRect:imageRect blendMode:kCGBlendModeLuminosity alpha:1.0];
    // Get the resulting image.
    UIImage *filteredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return filteredImage;
}
@end
