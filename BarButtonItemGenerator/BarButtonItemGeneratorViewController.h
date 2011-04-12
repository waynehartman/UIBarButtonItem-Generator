//
//  BarButtonItemGeneratorViewController.h
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

#import <UIKit/UIKit.h>
#import "WHSlider.h"

@interface BarButtonItemGeneratorViewController : UIViewController <UITextFieldDelegate> {
    WHSlider* sliderRed_;
    UITextField* textRed_;
    WHSlider* sliderBlue_;
    UITextField* textBlue_;
    WHSlider* sliderGreen_;
    UITextField* textGreen_;
    
    UITextField* buttonText_;
    
    UITextField* fileName_;
    
    UIBarButtonItem* sampleButton_;
    UIBarButtonItem* saveButton_;
    
    UIButton* dismissButton_;
}

- (IBAction) save:(id) sender;
- (IBAction) slideEvent:(id)sender;
- (IBAction) dismissKeyboard:(id) sender;

- (void) updateSampleButton;
- (void) saveImageWithFileName:(NSString*) filename withRetinaSize:(BOOL) retinaSize;
- (NSString*) createFileNameWithDown:(BOOL) down;

@property (nonatomic, retain) IBOutlet WHSlider *sliderRed;
@property (nonatomic, retain) IBOutlet UITextField *textRed;
@property (nonatomic, retain) IBOutlet WHSlider *sliderBlue;
@property (nonatomic, retain) IBOutlet UITextField *textBlue;
@property (nonatomic, retain) IBOutlet WHSlider *sliderGreen;
@property (nonatomic, retain) IBOutlet UITextField *textGreen;
@property (nonatomic, retain) IBOutlet UITextField *buttonText;
@property (nonatomic, retain) IBOutlet UITextField *fileName;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *sampleButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *dismissButton;

@end