//
//  ViewController.m
//  StackViewExample
//
//  Created by Nick Lockwood on 22/10/2013.
//  Copyright (c) 2013 Charcoal Design. All rights reserved.
//

#import "ViewController.h"
#import "StackView.h"


@interface ViewController ()

@property (nonatomic, weak) IBOutlet StackView *stackView;

@end


@implementation ViewController

- (IBAction)sliderAction:(UISlider *)sender
{
    self.stackView.contentSpacing = sender.value;
}

@end
