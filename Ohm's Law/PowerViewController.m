//
//  PowerViewController.m
//  Ohm's Law
//
//  Created by Robert Diamond on 5/19/11.
//  Copyright 2011 none. All rights reserved.
//

#import "PowerViewController.h"


@implementation PowerViewController
@synthesize pField;
@synthesize pUnit;
@synthesize vField;
@synthesize vUnit;
@synthesize iField;
@synthesize iUnit;
@synthesize rField;
@synthesize rUnit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)calculate:(id)sender {
    float vVal = nanf("v");
    float iVal = nanf("i");
    float rVal = nanf("r");
    float pVal = nanf("p");
    NSUInteger c = 0;
    
    if (vField.text) {
        vVal = [vField.text floatValue] * powf(.001, [vUnit selectedSegmentIndex]);
        ++c;
    }
    if (iField.text) {
        iVal = [iField.text floatValue] * powf(.001, [iUnit selectedSegmentIndex]);
        ++c;
    }
    if (rField.text) {
        rVal = [rField.text floatValue] * powf(1000, [rUnit selectedSegmentIndex]);
        ++c;
    }
    if (pField.text) {
        pVal = [pField.text floatValue] * powf(1000, 1.0f - [pUnit selectedSegmentIndex]);
        ++c;
    }
    
    if (c == 2 || c == 3) {
        if (isnan(vVal)) {
            if (isnan(pVal)) {
                vVal = iVal * rVal;
            } else {
                vVal = sqrtf(pVal * rVal);
            }
        }
        
        if (isnan(iVal)) {
            if (isnan(pVal)) {
                iVal = vVal/rVal;
            } else {
                iVal = sqrtf(pVal / rVal);
            }
        }
        
        if (isnan(rVal)) {
            if (isnan(pVal)) {
                rVal = vVal / iVal;
            } else {
                rVal = iVal * iVal / pVal;
            }
        }
        
        if (isnan(pVal)) {
            pVal = vVal * iVal;
        }
        
        CGFloat l10 = logf(10.0f);
        CGFloat magnitude = logf(vVal) / l10;
        vField.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:vVal] numberStyle:NSNumberFormatterDecimalStyle];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
