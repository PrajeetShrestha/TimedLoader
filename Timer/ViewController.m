//
//  ViewController.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/15/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "EkLoader.h"
#import "CircularLayer.h"

@interface ViewController () {
    NSTimer *timer;
    __weak IBOutlet UIView *containerView;
}
@property (nonatomic, strong) EkLoader *timeIndicator;
@property (nonatomic, strong) CircularLayer *circle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.blackAndWhitePic.image = [self grayishImage:self.blackAndWhitePic.image];


}

- (void)viewDidLayoutSubviews {
    CircularLayer *circle2 = [CircularLayer new];
    circle2.position  = CGPointMake(containerView.bounds.size.width / 2,75);
    [self.view.layer addSublayer:circle2];
    self.colorContainer.layer.mask = circle2;

    self.timeIndicator = [EkLoader new];
    self.timeIndicator.totalTime = 10;
    self.timeIndicator.alpha = 1.0;
    self.timeIndicator.position = CGPointMake(containerView.bounds.size.width / 2,75);
    //self.clockFace.time = 50;
    [containerView.layer addSublayer:self.timeIndicator];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(updateTime:)
                                           userInfo:nil
                                            repeats:YES];
    containerView.layer.mask = self.timeIndicator;
}

- (void)updateTime:(NSTimer *)timerPassed {
    if (self.timeIndicator.time >= self.timeIndicator.totalTime) {
        [timerPassed invalidate];
        NSLog(@"Timer invalidated");
    }
    self.timeIndicator.time = self.timeIndicator.time + 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
