//
//  LEDViewController.m
//  Ohm's Law
//
//  Created by Robert Diamond on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEDViewController.h"


@implementation LEDViewController

@synthesize vbat;
@synthesize iled;
@synthesize vled;
@synthesize ohms;
@synthesize amps;
@synthesize r;

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
    float vledval = nanf("vled");
    float iledval = nanf("iled");
    float vbatval = nanf("vbat");
    float rval = nanf("r");
    int setcnt = 0;
    
    if ([vled.text length]) {
        vledval = [vled.text floatValue];
        ++setcnt;
    }
    if ([iled.text length]) {
        iledval = [iled.text floatValue];
        iledval *= powf(.001, [amps selectedSegmentIndex]);
        ++setcnt;
    }
    if ([vbat.text length]) {
        vbatval = [vbat.text floatValue];
        ++setcnt;
    }
    if ([r.text length]) {
        rval = [r.text floatValue];
        rval *= powf(1000, [ohms selectedSegmentIndex]);
        ++setcnt;
    }
    NSString *error = nil;
    if (setcnt < 3) {
        error = @"Please fill in all but one value";
    } else if (setcnt == 4) {
        error = @"Please leave one value unknown";
    }
    if (error == nil) {
        if (isnan(vledval)) {
            vled.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:vbatval - iledval * rval] numberStyle:NSNumberFormatterDecimalStyle];
        } else if (isnan(iledval)) {
            if (rval == 0) {
                error = @"R can't be 0";
            } else {
                iledval = (vbatval - vledval) / rval;
                CGFloat iledmag = fmax(fmin(0.0f,floor(logf(iledval)/logf(10.0f)/3)),-2.0f);
                [amps setSelectedSegmentIndex:iledmag];
                iledval *= powf(1000.0f, -iledmag);
                iled.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:iledval] numberStyle:NSNumberFormatterDecimalStyle];
            }
        } else if (isnan(vbatval)) {
            vbat.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:vledval + iledval * rval] numberStyle:NSNumberFormatterDecimalStyle];
        } else if (isnan(rval)) {
            if (rval == 0) {
                error = @"I can't be 0";
            } else {
                rval = (vbatval - vledval)/iledval;
                CGFloat rledmag = fmin(fmax(0.0f,floor(logf(rval)/logf(10.0f)/3)),2.0f);
                [ohms setSelectedSegmentIndex:rledmag];
                rval *= powf(0.001f, rledmag);
                r.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:rval] numberStyle:NSNumberFormatterDecimalStyle];
            }
        }
    }
    if (error) {
        UIAlertView *uav = [[UIAlertView alloc]
                            initWithTitle:@"Can't calculate" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [uav show];
        [uav release];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [iled resignFirstResponder];
    [vled resignFirstResponder];
    [vbat resignFirstResponder];
    [r resignFirstResponder];
}

- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
