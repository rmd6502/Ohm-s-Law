//
//  LEDViewController.h
//  Ohm's Law
//
//  Created by Robert Diamond on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LEDViewController : UIViewController {
    
}

@property (nonatomic,assign) IBOutlet UITextField *vbat;
@property (nonatomic,assign) IBOutlet UITextField *vled;
@property (nonatomic,assign) IBOutlet UITextField *iled;
@property (nonatomic,assign) IBOutlet UITextField *r;

@property (nonatomic,assign) IBOutlet UISegmentedControl *amps;
@property (nonatomic,assign) IBOutlet UISegmentedControl *ohms;

- (IBAction)calculate:(id)sender;
- (IBAction)goBack:(id)sender;

@end
