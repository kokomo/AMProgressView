//
//  AMProgressViewGradient.m
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

#import "AMProgressViewGradient.h"

@interface AMProgressViewGradient ()
@property (nonatomic) BOOL vertical;
@property (nonatomic, strong) NSArray *gradientColors;
@end

@implementation AMProgressViewGradient

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andGradientColors:[NSArray arrayWithObject:[UIColor redColor]] andVertical:NO];
}

- (id)initWithFrame:(CGRect)frame andGradientColors:(NSArray *)gradientColors andVertical:(BOOL)vertical
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vertical = vertical;
        self.gradientColors = gradientColors;
        if ([self.gradientColors count] == 1) {
            self.backgroundColor = (UIColor *)[self.gradientColors objectAtIndex:0];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if ([self.gradientColors count] == 1) return;
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    int numComponents = 4;
    CGFloat colors[[self.gradientColors count] * numComponents];
    const CGFloat *components[[self.gradientColors count]];
    for (int i = 0; i < [self.gradientColors count]; i++) {
        components[i] = CGColorGetComponents(((UIColor *)[self.gradientColors objectAtIndex:i]).CGColor);
        for (int j = 0; j < numComponents; j++) {
            colors[i * numComponents + j] = components[i][j];
        }
    }
    CGGradientRef gradient = CGGradientCreateWithColorComponents (colorSpace, colors, NULL, [self.gradientColors count]);

    CGPoint startPoint;
    CGPoint endPoint;
    if (self.vertical) {
        startPoint = CGPointMake(0, rect.size.height);
        endPoint = CGPointMake(rect.origin.x, 0);
    } else {
        startPoint = CGPointMake(rect.origin.x, 0);
        endPoint = CGPointMake(rect.size.width, 0);
    }
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end