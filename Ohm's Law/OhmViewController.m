//
//  OhmViewController.m
//  Ohm's Law
//
//  Created by Robert Diamond on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OhmViewController.h"


@implementation OhmViewController
@synthesize e;
@synthesize i;
@synthesize r;
@synthesize amps;
@synthesize ohms;

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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [e resignFirstResponder];
    [i resignFirstResponder];
    [r resignFirstResponder];
}

- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)calculate:(id)sender {
    NSString *error = nil;
    
    CGFloat evalue = nanf("e");
    CGFloat ivalue = nanf("i");
    CGFloat rvalue = nanf("r");
    
    if ([e.text length] > 0) {
        evalue = [e.text floatValue];
    }
    if ([i.text length] > 0) {
        ivalue = [i.text floatValue];
        ivalue *= powf(.001, amps.selectedSegmentIndex);
    }
    if ([r.text length] > 0) {
        rvalue = [r.text floatValue];
        rvalue *= powf(1000, ohms.selectedSegmentIndex);
    }
    
    if (isnan(evalue)) {
        if ([i.text length] != 0 || [r.text length] != 0) {
            e.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:ivalue * rvalue] numberStyle:NSNumberFormatterDecimalStyle];
        } else {
            error = @"Please fill in two fields then hit calculate again";
        }
    } else if (isnan(ivalue)) {
        if ([e.text length] != 0 || [r.text length] != 0) {
            i.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:evalue / rvalue] numberStyle:NSNumberFormatterDecimalStyle];
        } else {
            error = @"Please fill in two fields then hit calculate again";
        }
    } else if (isnan(rvalue)) {
        if ([i.text length] != 0 || [e.text length] != 0) {
            r.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:evalue / ivalue] numberStyle:NSNumberFormatterDecimalStyle];
        } else {
            error = @"Please fill in two fields then hit calculate again";
        }
    } else {
        error = @"Please leave one field blank as an unknown";
    }
    if (error) {
        UIAlertView *uav = [[UIAlertView alloc] initWithTitle:@"Can't Calculate" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [uav show];
        [uav release];
    }
}

@end
