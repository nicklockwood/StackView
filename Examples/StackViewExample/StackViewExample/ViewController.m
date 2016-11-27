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

@property (nonatomic, strong) IBOutlet StackView *stackView;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inset content from edge
    self.stackView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //set spacing between items
    self.stackView.contentSpacing = 10;
}

- (IBAction)sliderAction:(UISlider *)sender
{
    self.stackView.contentSpacing = (CGFloat)sender.value;
}

@end
