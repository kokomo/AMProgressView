//
//  AMProgressView.h
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

#import <UIKit/UIKit.h>

@interface AMProgressView : UIView

//
//     frame:          As usual.
//     gradientColors: Array of colors to create the background gradient. It can be any number of
//                     UIColor objects, although less colors generate better results. If a single
//                     color is used, the progress view will be drawn with no gradient. If 'nil' is
//                     passed, a standard red to yellow to green gradient is generated automatically.
//     outsideBorder:  Sets if the progress view has (YES) or not (NO) a border.
//     vertical:       Sets if the progress view is vertical (YES) or horizontal (NO).
//
- (id)initWithFrame:(CGRect)frame
  andGradientColors:(NSArray *)gradientColors
   andOutsideBorder:(BOOL)outsideBorder
        andVertical:(BOOL)vertical;

@property (nonatomic) float minimumValue; // default: 0.0f
@property (nonatomic) float maximumValue; // default: 1.0f
@property (nonatomic) float progress; // default: 0.0f
@property (nonatomic) float emptyPartAlpha; // from 0.0f -transparent, nonsense- to 1.0f -white- (default: 0.75f)
@property (nonatomic) float progressAnimationDuration; // default: 0.2f
@property (nonatomic, strong) UIColor *outsideBorderColor; // default: black

@property (nonatomic, strong, readonly) NSArray *gradientColors; // must be specified via initializer method
@property (nonatomic, readonly) BOOL outsideBorder; // must be specified via initializer method
@property (nonatomic, readonly) BOOL vertical; // must be specified via initializer method

@end