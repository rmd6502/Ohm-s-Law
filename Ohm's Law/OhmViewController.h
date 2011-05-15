//
//  OhmViewController.h
//  Ohm's Law
//
//  Created by Robert Diamond on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OhmViewController : UIViewController {
    
}

@property (nonatomic,assign) IBOutlet UITextField *e;
@property (nonatomic,assign) IBOutlet UITextField *i;
@property (nonatomic,assign) IBOutlet UITextField *r;
@property (nonatomic,assign) IBOutlet UISegmentedControl *amps;
@property (nonatomic,assign) IBOutlet UISegmentedControl *ohms;

- (IBAction)calculate:(id)sender;
- (IBAction)goBack:(id)sender;

@end
