

//
//  CircularLayer.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/16/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "CircularLayer.h"
@import UIKit;

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
