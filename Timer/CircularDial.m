//
//  CircularDial.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/16/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "CircularDial.h"
@interface CircularDial() {
    UIImageView *blackAndWhiteImageView;
    UIImageView *coloredImageView;
    NSTimer *timer;

}
 @property (nonatomic)  EkLoader *timeIndicator;
@end
@implementation CircularDial

@synthesize blackAndWhiteImageContainer;
@synthesize colorImageContainer;
- (void)setUpSubViews {
    NSLog(@" SELF %@",self);
    blackAndWhiteImageContainer = [UIView new];
    colorImageContainer = [UIView new];
    blackAndWhiteImageView = [UIImageView new];
    coloredImageView = [UIImageView new];

    blackAndWhiteImageContainer.frame = self.bounds;
    colorImageContainer.frame = self.bounds;
    [self addSubview:blackAndWhiteImageContainer];
    [self addSubview:colorImageContainer];

    blackAndWhiteImageView.frame = blackAndWhiteImageContainer.bounds;
    coloredImageView.frame = colorImageContainer.bounds;

    [blackAndWhiteImageContainer addSubview:blackAndWhiteImageView];
    blackAndWhiteImageView.image = [self grayishImage:self.image];

    [colorImageContainer addSubview:coloredImageView];
    coloredImageView.image = self.image;

    coloredImageView.contentMode = UIViewContentModeScaleAspectFill;
    blackAndWhiteImageView.contentMode = UIViewContentModeScaleAspectFill;

    CircularLayer *circle2 = [CircularLayer new];
    circle2.position  = CGPointMake(colorImageContainer.bounds.size.width / 2,70);
    [self.layer addSublayer:circle2];
    self.blackAndWhiteImageContainer.layer.mask = circle2;

    self.timeIndicator = [EkLoader new];
    self.timeIndicator.totalTime = 10;
    self.timeIndicator.alpha = 1.0;
    self.timeIndicator.position = CGPointMake(colorImageContainer.bounds.size.width / 2,70);
    [blackAndWhiteImageContainer.layer addSublayer:self.timeIndicator];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(updateTime:)
                                           userInfo:nil
                                            repeats:YES];
    colorImageContainer.layer.mask = self.timeIndicator;
}

#pragma mark - Private Methods
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

- (void)updateTime:(NSTimer *)timerPassed {
    if (self.timeIndicator.time >= self.timeIndicator.totalTime) {
        [timerPassed invalidate];
        NSLog(@"Timer invalidated");
    }
    self.timeIndicator.time = self.timeIndicator.time + 0.1;
}

@end

#pragma mark CircularLayer Implementation
@implementation CircularLayer
- (id)init
{
    if ((self = [super init]))
    {
        self.bounds = CGRectMake(0, 0, 140, 140);
        [self setNeedsDisplay];
    }
    return self;
}
- (void)display
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(ctx, CGRectInset(self.bounds, 0, 0));
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
}




@end

@implementation EkLoader

@dynamic time;

- (id)init
{
    if ((self = [super init]))
    {
        self.bounds = CGRectMake(0, 0, 140, 140);
        [self setNeedsDisplay];
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([@"time" isEqualToString:key])
    {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)key
{
    if ([key isEqualToString:@"time"])
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.fromValue = @([[self presentationLayer] time]);
        return animation;
    }
    return [super actionForKey:key];
}

- (void)display
{
    //get interpolated time value
    float time = [self.presentationLayer time];
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //draw clock face
    CGContextSetStrokeColorWithColor(ctx, [UIColor darkGrayColor].CGColor);
    CGContextSetLineWidth(ctx, 2);
    //CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 2, 2));
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);

    if (time > 0) {
        CGFloat angle = (360/self.totalTime) * self.time;
        angle = DEGREES_TO_RADIANS(angle);
        CGContextSetLineWidth(ctx, 5);
        CGContextSetAlpha(ctx, self.alpha);
        CGContextMoveToPoint(ctx, center.x, center.y);
        CGContextAddLineToPoint(ctx, (int)(center.x + cos(angle) * kCircleRadius),(int)( center.y + sin(angle) * kCircleRadius));
        CGContextMoveToPoint(ctx, center.x, center.y);
        CGContextAddLineToPoint(ctx, (int)(center.x + cos(0) * kCircleRadius),(int)( center.y + sin(0) * kCircleRadius));
        CGContextAddArc(ctx, center.x, center.y, kCircleRadius, 0, angle, 0);
        CGContextFillPath(ctx);
        CGContextStrokePath(ctx);
        self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    }

    UIGraphicsEndImageContext();
    self.transform = CATransform3DMakeRotation(-90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
}
@end