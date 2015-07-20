//
//  BorderLayer.m
//  Timer
//
//  Created by Prajeet Shrestha on 7/20/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "BorderLayer.h"
@import UIKit;
@interface BorderLayer(){

}
@property (nonatomic)float frameHeight;
@end

@implementation BorderLayer

- (instancetype)initWithFrame:(CGRect)frame {

    if ((self = [super initWithFrame:frame]))
    {

    }
    return self;

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGFloat lineWidth = 10;
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetAlpha(ctx, 0.5);
    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, lineWidth/2, lineWidth/2));
}
@end
