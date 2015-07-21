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

@property (nonatomic) EkLoader *hands;

@end
@implementation CircularDial


@synthesize blackAndWhiteImageContainer;
@synthesize colorImageContainer;


- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
}
- (void)setUpSubViews {

    NSArray *subviews = [self subviews];
    for (UIView *view in subviews){
        [view removeFromSuperview];
    }

    CGRect insetRect  = CGRectInset(self.bounds, 10, 10);
    blackAndWhiteImageContainer = [UIView new];
    colorImageContainer = [UIView new];
    blackAndWhiteImageView = [UIImageView new];
    coloredImageView = [UIImageView new];

    blackAndWhiteImageContainer.frame = insetRect;
    colorImageContainer.frame = insetRect;
    [self addSubview:blackAndWhiteImageContainer];
    [self addSubview:colorImageContainer];

    blackAndWhiteImageView.frame = blackAndWhiteImageContainer.bounds;
    coloredImageView.frame = colorImageContainer.bounds;

    [blackAndWhiteImageContainer addSubview:blackAndWhiteImageView];
    blackAndWhiteImageView.image = self.image;//[self grayishImage:self.image];

    [colorImageContainer addSubview:coloredImageView];
    coloredImageView.image = [self grayishImage:self.image];//self.image;

    coloredImageView.contentMode = UIViewContentModeScaleAspectFill;
    blackAndWhiteImageView.contentMode = UIViewContentModeScaleAspectFill;

    CircularLayer *circle2 = [[CircularLayer alloc]initWithFrameHeight:insetRect.size.height];
    circle2.position  = CGPointMake(colorImageContainer.bounds.size.width / 2,insetRect.size.height/2);
    [self.layer addSublayer:circle2];
    self.blackAndWhiteImageContainer.layer.mask = circle2;

    self.timeIndicator = [[EkLoader alloc]initWithFrameHeight:insetRect.size.height];
    self.timeIndicator.totalTime = self.totalTime;
    self.timeIndicator.position = CGPointMake(colorImageContainer.bounds.size.width / 2,insetRect.size.height/2);
    [blackAndWhiteImageContainer.layer addSublayer:self.timeIndicator];
    colorImageContainer.layer.mask = self.timeIndicator;

    BorderLayer *borderCircle = [[BorderLayer alloc]initWithFrame:insetRect];
    borderCircle.backgroundColor = [UIColor clearColor];
    [self addSubview:borderCircle];

    self.hands = [[EkLoader alloc]initWithFrameHeight:self.bounds.size.height];
    self.hands.totalTime = self.totalTime;
    self.hands.isHand = YES;
    self.hands.position = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height/2);
    [self.layer addSublayer:self.hands];

}



- (float)getTimeForTimeIndicator {
    return self.timeIndicator.time;
}

- (void)playTimer {
    self.isPlaying = YES;
    self.isPaused = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(updateTime:)
                                           userInfo:nil
                                            repeats:YES];
    if (self.hands.superlayer == nil) {
        [self.layer addSublayer:self.hands];
    }


}

- (void)pauseTimer {
    self.isPlaying = NO;
    self.isPaused = YES;
    [timer invalidate];
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
        [self.hands removeFromSuperlayer];
        [timerPassed invalidate];

        NSLog(@"Timer invalidated");
    }
    self.hands.opacity = 1.0f;
    self.timeIndicator.time = self.timeIndicator.time + 0.1;
    self.hands.time = self.hands.time +0.1;
}

@end

#pragma mark CircularLayer Implementation
@implementation CircularLayer
- (id)initWithFrameHeight:(float)frameHeight
{
    if ((self = [super init]))
    {
        NSLog(@"%f Frame Height",frameHeight);
        self.bounds = CGRectMake(0, 0, frameHeight, frameHeight);
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

#pragma mark - EKLoader Implementation
@implementation EkLoader

@dynamic time;

- (id)initWithFrameHeight:(float)frameHeight;
{
    if ((self = [super init]))
    {
        self.bounds = CGRectMake(0, 0, frameHeight, frameHeight);
        self.frameHeight = frameHeight;
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
    //    CGContextSetStrokeColorWithColor(ctx, [UIColor darkGrayColor].CGColor);
    //    CGContextSetLineWidth(ctx, 10);
    //    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 5, 5));
    CGPoint center = CGPointMake(self.frameHeight/2, self.frameHeight/2);

    if (time > 0) {
        CGFloat angle = (360/self.totalTime) * self.time;

        angle = DEGREES_TO_RADIANS(angle);
        if (!self.isHand) {
            CGContextMoveToPoint(ctx, center.x, center.y);
            CGContextAddArc(ctx, center.x, center.y, (self.frameHeight/2), 0, angle, 0);
            CGContextFillPath(ctx);
        } else {
            CGContextSetLineWidth(ctx, 1);
            CGFloat offset = 20;
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextMoveToPoint(ctx, (int)(center.x  + cos(0) * (self.frameHeight/2 - offset)),(int)( center.y + sin(0) * (self.frameHeight/2 - offset)));
            CGContextAddLineToPoint(ctx, (int)(center.x + cos(0) * (self.frameHeight/2 - 7)),(int)( center.y + sin(0) * (self.frameHeight/2 - 7)));
            CGContextMoveToPoint(ctx, (int)(center.x + cos(angle) * (self.frameHeight/2 - offset)),(int)( center.y + sin(angle) * (self.frameHeight/2 - offset)));
            CGContextAddLineToPoint(ctx, (int)(center.x + cos(angle) * (self.frameHeight/2 - 7 )),(int)( center.y  + sin(angle) * (self.frameHeight/2 - 7 )));
            CGContextStrokePath(ctx);
        }
        self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
        //CGContextSetLineWidth(ctx, 1);
        //CGContextSetAlpha(ctx, self.alpha);
        //CGContextAddLineToPoint(ctx, (int)(center.x + cos(angle) * (self.frameHeight/2)),(int)( center.y + sin(angle) * (self.frameHeight/2)));
        //CGContextMoveToPoint(ctx, center.x, center.y);
        //CGContextAddLineToPoint(ctx, (int)(center.x + cos(0) * (self.frameHeight/2)),(int)( center.y + sin(0) * (self.frameHeight/2)));
        //CGContextStrokePath(ctx);
    }
    
    UIGraphicsEndImageContext();
    self.transform = CATransform3DMakeRotation(-90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
}
@end