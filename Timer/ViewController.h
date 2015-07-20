//
//  ViewController.h
//  Timer
//
//  Created by Prajeet Shrestha on 7/15/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularDial.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet CircularDial *dial;
- (IBAction)play:(id)sender;
@end

