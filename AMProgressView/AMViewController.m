//
//  AMViewController.m
//  AMProgressView
//
//  Created by Albert Mata on 15/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMViewController.h"

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    // Instantiate: standard red to yellow to green with border
    AMProgressView *pv1 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 30, 200, 20)
                                            andGradientColors:nil
                                             andOutsideBorder:YES
                                                  andVertical:NO];
    // Display
    [self.view addSubview:pv1];
    
    
    // Instantiate: white to black with border
    AMProgressView *pv2 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 80, 200, 50)
                                            andGradientColors:[NSArray arrayWithObjects:[UIColor whiteColor], [UIColor blackColor], nil]
                                             andOutsideBorder:YES
                                                  andVertical:NO];
    // Display
    [self.view addSubview:pv2];
    
    
    // Instantiate: red to yellow with slow animation for value changes
    AMProgressView *pv3 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 160, 200, 30)
                                            andGradientColors:[NSArray arrayWithObjects:[UIColor redColor], [UIColor yellowColor], nil]
                                             andOutsideBorder:NO
                                                  andVertical:NO];
    // Configure
    pv3.emptyPartAlpha = 0.5f;
    pv3.progressAnimationDuration = 0.5f;
    // Display
    [self.view addSubview:pv3];
    
    
    // Instantiate: yellow to green with border and without animation for value changes
    AMProgressView *pv4 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 220, 200, 40)
                                            andGradientColors:[NSArray arrayWithObjects:[UIColor yellowColor], [UIColor greenColor], nil]
                                             andOutsideBorder:YES
                                                  andVertical:NO];
    // Configure
    pv4.progressAnimationDuration = 0.0f;
    pv4.outsideBorderColor = [UIColor colorWithRed:0.0f green:0.6f blue:0.0f alpha:1.0f];
    // Display
    [self.view addSubview:pv4];
    
    
    // Instantiate: solid orange (no gradient) with no transparency for empty part
    AMProgressView *pv5 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 290, 200, 30)
                                            andGradientColors:[NSArray arrayWithObjects:[UIColor orangeColor], nil]
                                             andOutsideBorder:NO
                                                  andVertical:NO];
    // Configure
    pv5.emptyPartAlpha = 1.0f;
    // Display
    [self.view addSubview:pv5];
    
    
    // Instantiate: purple to white with border
    AMProgressView *pv6 = [[AMProgressView alloc] initWithFrame:CGRectMake(20, 350, 200, 25)
                                            andGradientColors:[NSArray arrayWithObjects:[UIColor purpleColor], [UIColor whiteColor], nil]
                                             andOutsideBorder:YES
                                                  andVertical:NO];
    // Configure
    pv6.outsideBorderColor = [UIColor purpleColor];
    // Display
    [self.view addSubview:pv6];
    
    
    // Instantiate: vertical standard red to yellow to green with border
    AMProgressView *pv7 = [[AMProgressView alloc] initWithFrame:CGRectMake(235, 30, 20, 345)
                                            andGradientColors:nil
                                             andOutsideBorder:YES
                                                  andVertical:YES];
    // Display
    [self.view addSubview:pv7];
    
    
    // Instantiate: vertical dark blue to light blue
    AMProgressView *pv8 = [[AMProgressView alloc] initWithFrame:CGRectMake(270, 30, 30, 345)
                                            andGradientColors:[NSArray arrayWithObjects:
                                                               [UIColor colorWithRed:0.0f green:0.0f blue:0.3f alpha:0.50f],
                                                               [UIColor colorWithRed:0.3f green:0.3f blue:0.6f alpha:0.75f],
                                                               [UIColor colorWithRed:0.6f green:0.6f blue:0.9f alpha:1.00f], nil]
                                             andOutsideBorder:NO
                                                  andVertical:YES];
    // Configure
    pv8.emptyPartAlpha = 0.8f;
    // Display
    [self.view addSubview:pv8];
    
    
    self.pv1 = pv1;
    self.pv2 = pv2;
    self.pv3 = pv3;
    self.pv4 = pv4;
    self.pv5 = pv5;
    self.pv6 = pv6;
    self.pv7 = pv7;
    self.pv8 = pv8;
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(113, 401, 94, 27)];
    stepper.minimumValue = 0.0f;
    stepper.maximumValue = 1.0f;
    stepper.value = 0.0f;
    stepper.stepValue = 0.1f;
    [stepper addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
}

- (void)changeValue:(UIStepper *)sender {
    self.pv1.progress = sender.value;
    self.pv2.progress = sender.value;
    self.pv3.progress = sender.value;
    self.pv4.progress = sender.value;
    self.pv5.progress = sender.value;
    self.pv6.progress = sender.value;
    self.pv7.progress = sender.value;
    self.pv8.progress = sender.value;
}

@end