//
//  ClockFace.m
//  ClockFace
//
//  Created by Nick Lockwood on 28/04/2014.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "EkLoader.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define kCircleRadius 70
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