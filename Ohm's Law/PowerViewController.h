//
//  PowerViewController.h
//  Ohm's Law
//
//  Created by Robert Diamond on 5/19/11.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PowerViewController : UIViewController {
    
}

@property (nonatomic,assign) IBOutlet UITextField *pField;
@property (nonatomic,assign) IBOutlet UISegmentedControl *pUnit;
@property (nonatomic,assign) IBOutlet UITextField *vField;
@property (nonatomic,assign) IBOutlet UISegmentedControl *vUnit;
@property (nonatomic,assign) IBOutlet UITextField *iField;
@property (nonatomic,assign) IBOutlet UISegmentedControl *iUnit;
@property (nonatomic,assign) IBOutlet UITextField *rField;
@property (nonatomic,assign) IBOutlet UISegmentedControl *rUnit;

- (IBAction)calculate:(id)sender;
- (IBAction)goBack:(id)sender;

- (void)kbWillShow:(NSNotification *)notif;
- (void)kbWillHide:(NSNotification *)notif;

@end
