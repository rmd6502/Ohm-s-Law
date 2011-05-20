//
//  Ohm_s_LawViewController.m
//  Ohm's Law
//
//  Created by Robert Diamond on 5/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "Ohm_s_LawViewController.h"
#import "OhmViewController.h"
#import "PowerViewController.h"

static struct Functions {
    NSString *funcName;
    NSString *className;
} functions[] = {
    {@"Ohm's Law", @"OhmViewController"},
    {@"LED Dropping Resistor", @"LEDViewController"},
    {@"Power Calculations", @"PowerViewController"},
};


@implementation Ohm_s_LawViewController

@synthesize formulaPicker;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return sizeof(functions)/sizeof(struct Functions);
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return functions[row].funcName;
}

- (IBAction)chooseFormula:(id)sender {
    Class cl = (Class)objc_getClass([functions[[formulaPicker selectedRowInComponent:0]].className UTF8String]);
    UIViewController *fvc = class_createInstance(cl, 0);
    [fvc initWithNibName:nil bundle:nil];
    [self presentModalViewController:fvc animated:YES];
}
@end
