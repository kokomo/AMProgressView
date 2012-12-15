//
//  AMProgressView.m
//  AMProgressView
//
//  Created by Albert Mata on 15/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved. FreeBSD License.
//  Please send comments/corrections to hello@albertmata.net or @almata on Twitter.
//  Download latest version from https://github.com/almata/AMProgressView
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
//

#import "AMProgressView.h"
#import "AMProgressViewGradient.h"

@interface AMProgressView ()
@property (nonatomic, weak) UIView *borderView;
@property (nonatomic, weak) UIView *whiteView;
@property (nonatomic, weak) AMProgressViewGradient *gradientView;
@property (nonatomic) BOOL firstTimeProgressValueIsSet;
@end

@implementation AMProgressView

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andGradientColors:nil andOutsideBorder:NO andVertical:NO];
}

- (id)initWithFrame:(CGRect)frame
  andGradientColors:(NSArray *)gradientColors
   andOutsideBorder:(BOOL)outsideBorder
        andVertical:(BOOL)vertical
{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstTimeProgressValueIsSet = YES;
        _outsideBorder = outsideBorder;
        _vertical = vertical;
        NSMutableArray *colors;
        // Default gradient is a red to yellow to green
        if (!gradientColors) {
            colors = [[NSMutableArray alloc] initWithObjects:
                      [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f],
                      [UIColor colorWithRed:1.0f green:0.8f blue:0.0f alpha:1.0f],
                      [UIColor colorWithRed:0.0f green:0.8f blue:0.0f alpha:1.0f],
                      nil];
        } else {
            colors = [[NSMutableArray alloc] init];
            for (__strong UIColor* c in gradientColors) {
                // Colors white, light gray, dark gray and black are problematic
                if ([c isEqual:[UIColor blackColor]]) c = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
                if ([c isEqual:[UIColor darkGrayColor]]) c = [UIColor colorWithRed:0.333f green:0.333f blue:0.333f alpha:1.0f];
                if ([c isEqual:[UIColor lightGrayColor]]) c = [UIColor colorWithRed:0.666f green:0.666f blue:0.666f alpha:1.0f];
                if ([c isEqual:[UIColor whiteColor]]) c = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
                [colors addObject:c];
            }
        }
        _gradientColors = colors;
        
        UIView *wv = [[UIView alloc] init];
        self.whiteView = wv;
        self.whiteView.backgroundColor = [UIColor whiteColor];
        
        // Setting default values for properties (begin)
        self.minimumValue = 0.0f;
        self.maximumValue = 1.0f;
        self.emptyPartAlpha = 0.75f;
        self.progressAnimationDuration = 0.20f;
        self.whiteView.alpha = self.emptyPartAlpha;
        self.outsideBorderColor = [UIColor blackColor];
        // Setting default values for properties (end)

        AMProgressViewGradient *pvg;
        if (self.outsideBorder) {
            UIView *bv = [[UIView alloc]
                          initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            self.borderView = bv;
            self.borderView.backgroundColor = self.outsideBorderColor;
            [self addSubview:self.borderView];
            pvg = [[AMProgressViewGradient alloc]
                   initWithFrame:CGRectMake(1, 1, frame.size.width - 2, frame.size.height - 2)
                   andGradientColors:self.gradientColors
                   andVertical:self.vertical];
        } else {
            pvg = [[AMProgressViewGradient alloc]
                   initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                   andGradientColors:self.gradientColors
                   andVertical:self.vertical];
        }
        self.gradientView = pvg;
        [self addSubview:self.gradientView];
        [self addSubview:self.whiteView];
        [self changeWhiteView];
    }
    return self;
}

#pragma mark - Accessors

- (void)setProgress:(float)progress
{
    _progress = MIN(self.maximumValue, MAX(self.minimumValue, progress));
    [self changeWhiteView];
}

- (void)setEmptyPartAlpha:(float)emptyPartAlpha
{
    _emptyPartAlpha = emptyPartAlpha;
    self.whiteView.alpha = emptyPartAlpha;
}

- (void)setOutsideBorderColor:(UIColor *)outsideBorderColor
{
    _outsideBorderColor = outsideBorderColor;
    self.borderView.backgroundColor = self.outsideBorderColor;
}

#pragma mark - Private methods

- (void)changeWhiteView
{
    float x = 0.0f;
    float y = 0.0f;
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    if (self.vertical) {
        if (self.outsideBorder) {
            x += 1.0f; y += 1.0f; width -= 2.0f; height -= 2.0f;
        }
        height = MAX(0, height - (self.progress / (self.maximumValue - self.minimumValue)) * height);
    } else {
        if (self.outsideBorder) {
            x += 1.0f; y += 1.0f; width -= 1.0f; height -= 2.0f;
        }
        x = x + (self.progress / (self.maximumValue - self.minimumValue)) * width;
        width = MAX(0, width - x);
    }
    
    if (self.progressAnimationDuration > 0.0f  && !self.firstTimeProgressValueIsSet) {
        [UIView animateWithDuration:self.progressAnimationDuration animations:^() {
            self.whiteView.frame = CGRectMake(x, y, width, height);
        }];
    } else {
        self.whiteView.frame = CGRectMake(x, y, width, height);
    }
    
    self.firstTimeProgressValueIsSet = NO;
}

@end