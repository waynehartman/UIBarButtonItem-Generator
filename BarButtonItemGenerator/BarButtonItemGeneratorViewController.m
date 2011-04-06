//
//  BarButtonItemGeneratorViewController.m
//  BarButtonItemGenerator
//
// Copyright (c) 2011, Wayne Hartman
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// * Redistributions in binary form must 
// reproduce the above copyright notice, this list of conditions and the following disclaimer 
//   in the documentation and/or other materials provided with the distribution.
// * Neither the name of Wayne Hartman nor the names of its contributors may be used to endorse or promote products derived from 
//  this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS 
// BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
// DAMAGE.
//

#import <QuartzCore/QuartzCore.h>
#import "BarButtonItemGeneratorViewController.h"
#import "WHSlider.h"
#import "WHTextField.h"
#import "UIBarButtonItem+Tint.h"
@implementation BarButtonItemGeneratorViewController

bool isRetina()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0;
}

void RetinaAwareUIGraphicsBeginImageContext(CGSize size) {
    static CGFloat scale = -1.0;
    if (scale<0.0) {
        UIScreen *screen = [UIScreen mainScreen];
        if (isRetina()) {
            scale = [screen scale];
        }
        else {
            scale = 0.0; // mean use old api
        }
    }
    if (scale>0.0) {
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    }
    else {
        UIGraphicsBeginImageContext(size);
    }
}

@synthesize sliderRed = sliderRed_;
@synthesize textRed = textRed_;
@synthesize sliderBlue = sliderBlue_;
@synthesize textBlue = textBlue_;
@synthesize sliderGreen = sliderGreen_;
@synthesize textGreen = textGreen_;
@synthesize buttonText = buttonText_;
@synthesize sampleButton = sampleButton_;
@synthesize saveButton = saveButton_;
@synthesize dismissButton = dismissButton_;
@synthesize fileName = fileName_;

#pragma mark - View lifecycle

static NSString* formattedValue = @"%2.0f";

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSampleButton];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.sliderRed = nil;
    self.textRed = nil;
    self.sliderBlue = nil;
    self.textBlue = nil;
    self.sliderGreen = nil;
    self.textGreen = nil;
    self.buttonText = nil;
    self.sampleButton = nil;
    self.saveButton = nil;
    self.dismissButton = nil;
    self.fileName = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateSampleButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 
#pragma mark Instance Methods

- (void) save:(id)sender
{
    NSString* filename = [self createFileNameWithDown:NO];
    
    [self saveImageWithFileName:filename withRetinaSuffix:isRetina()];
}

- (void) saveDownPress:(id)sender
{
    NSString* filename = [self createFileNameWithDown:YES];
    
    [self saveImageWithFileName:filename withRetinaSuffix:isRetina()];
}

- (void) slideEvent:(id)sender
{
    if ([sender isKindOfClass:[WHSlider class]])
    {
        WHSlider* slider = (WHSlider*)sender;
        
        slider.boundField.text = [NSString stringWithFormat:formattedValue, slider.value];
        
        [self updateSampleButton];
    }
}

- (void) saveImageWithFileName:(NSString*) filename withRetinaSuffix:(BOOL) addSuffix
{
    CALayer* layer = [self.sampleButton layer];
    
    RetinaAwareUIGraphicsBeginImageContext(layer.frame.size);
    
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    [layer renderInContext:theContext];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *theData = UIImagePNGRepresentation(theImage);
    
    [theData writeToFile:[NSString stringWithFormat:@"/Users/YourUserName/Desktop/%@%@.png", filename, addSuffix ? @"@2x" : @""] atomically:NO];
    
    UIGraphicsEndImageContext();
}

- (NSString*) createFileNameWithDown:(BOOL) down
{
    NSString* filename = [NSString stringWithFormat:@"%@%@",[self.fileName.text length] == 0 ? @"defaultName" : self.fileName.text, down ? @"Down" : @""];
    
    return filename;
}

- (void) updateSampleButton
{
    UIColor* color = [UIColor colorWithRed:self.sliderRed.value/255.0f green:self.sliderGreen.value/255.0f blue:self.sliderBlue.value/255.0f alpha:1.0f];
    
    [self.sampleButton setTint:color];
    self.sampleButton.title = self.buttonText.text;
}

- (IBAction) dismissKeyboard:(id) sender
{
    [self.textRed resignFirstResponder];
    [self.textGreen resignFirstResponder];
    [self.textBlue resignFirstResponder];
    [self.buttonText resignFirstResponder];
    [self.fileName resignFirstResponder];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [self updateSampleButton];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isKindOfClass:[WHTextField class]])
    {
        WHTextField* field = (WHTextField*)textField;
        
        float value = [[NSString stringWithFormat:@"%@%@",textField.text, string] floatValue];
        
        field.boundSlider.value = value;
        
        [self updateSampleButton];
    }    
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self updateSampleButton];
    [textField resignFirstResponder];
    
    return NO;
}

#pragma mark -
#pragma mark Memory Management
- (void)dealloc
{
    [sliderRed_ release];
    sliderRed_ = nil;
    [textRed_ release];
    textRed_ = nil;
    [sliderBlue_ release];
    sliderBlue_ = nil;
    [textBlue_ release];
    textBlue_ = nil;
    [sliderGreen_ release];
    sliderGreen_ = nil;
    [textGreen_ release];
    textGreen_ = nil;
    [buttonText_ release];
    buttonText_ = nil;
    [sampleButton_ release];
    sampleButton_ = nil;
    [saveButton_ release];
    saveButton_ = nil;
    [dismissButton_ release];
    dismissButton_ = nil;
    [fileName_ release];
    fileName_ = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end