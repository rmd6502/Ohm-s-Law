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
    ((UIScrollView *)self.view).contentSize = self.view.bounds.size;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)kbWillShow:(NSNotification *)notif {
    CGRect ht = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGRect fr = self.view.frame;
    fr.size.height -= ht.size.height;
    self.view.frame = fr;
    [self.view setNeedsLayout];
}

- (void)kbWillHide:(NSNotification *)notif {
    CGRect ht = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect fr = self.view.frame;
    fr.size.height += ht.size.height;
    self.view.frame = fr;
    [self.view setNeedsLayout];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    
    if ([vField.text length]) {
        vVal = [vField.text floatValue] * powf(.001, [vUnit selectedSegmentIndex]);
        ++c;
    }
    if ([iField.text length]) {
        iVal = [iField.text floatValue] * powf(.001, [iUnit selectedSegmentIndex]);
        ++c;
    }
    if ([rField.text length]) {
        rVal = [rField.text floatValue] * powf(1000, [rUnit selectedSegmentIndex]);
        ++c;
    }
    if ([pField.text length]) {
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
        
        CGFloat l10 = 3.0f * logf(10.0f);
        CGFloat magnitude = -MIN(MAX(floorf(logf(vVal) / l10), -2), 0);
        vVal *= pow(1000, magnitude);
        vUnit.selectedSegmentIndex = magnitude;
        vField.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:vVal] numberStyle:NSNumberFormatterDecimalStyle];
        
        magnitude = -MIN(MAX(floorf(logf(iVal) / l10), -2), 0);
        iVal *= pow(1000, magnitude);
        iUnit.selectedSegmentIndex = magnitude;
        iField.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:iVal] numberStyle:NSNumberFormatterDecimalStyle];
        
        magnitude = MAX(MIN(floorf(logf(rVal) / l10), 2), 0);
        rVal *= pow(.001, magnitude);
        rUnit.selectedSegmentIndex = magnitude;
        rField.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:rVal] numberStyle:NSNumberFormatterDecimalStyle];
        
        magnitude = MIN(MAX(floorf(logf(pVal) / l10), -2), 1);
        pVal *= pow(.001, magnitude);
        pUnit.selectedSegmentIndex = 1 - magnitude;
        pField.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithFloat:pVal] numberStyle:NSNumberFormatterDecimalStyle];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self calculate:textField];
    [textField resignFirstResponder];
    return NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [vField resignFirstResponder];
    [iField resignFirstResponder];
    [rField resignFirstResponder];
    [pField resignFirstResponder];
}

- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
