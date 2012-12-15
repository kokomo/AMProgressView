//
//  AMViewController.h
//  AMProgressView
//
//  Created by Albert Mata on 15/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMProgressView.h"

@interface AMViewController : UIViewController

@property (nonatomic, weak) AMProgressView *pv1;
@property (nonatomic, weak) AMProgressView *pv2;
@property (nonatomic, weak) AMProgressView *pv3;
@property (nonatomic, weak) AMProgressView *pv4;
@property (nonatomic, weak) AMProgressView *pv5;
@property (nonatomic, weak) AMProgressView *pv6;
@property (nonatomic, weak) AMProgressView *pv7;
@property (nonatomic, weak) AMProgressView *pv8;

- (void)changeValue:(id)sender;

@end