//
//  StackView.m
//
//  Version 1.0.3
//
//  Created by Nick Lockwood on 18/02/2012.
//  Copyright (c) 2012 Charcoal Design. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/StackView
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//


#import "StackView.h"


@implementation StackView

- (BOOL)viewIsScrollbar:(UIView *)view
{
    CGFloat scrollbarSize = ([[UIDevice currentDevice].systemVersion floatValue] >= 7)? 3.5: 7;
    if ([view isKindOfClass:[UIImageView class]])
    {
        CGRect frame = view.frame;
        if (frame.size.width == scrollbarSize || frame.size.height == scrollbarSize)
        {
            return YES;
        }
    }
    return NO;
}

- (void)setContentSpacing:(CGFloat)contentSpacing
{
    _contentSpacing = contentSpacing;
    [self setNeedsLayout];
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
    _maxHeight = maxHeight;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self calculateContentSizeThatFits:self.frame.size andUpdateLayout:YES];
}

- (CGSize)calculateContentSizeThatFits:(CGSize)size andUpdateLayout:(BOOL)update
{
    UIEdgeInsets inset = self.contentInset;
    size.width -= (inset.left + inset.right);
    size.height -= (inset.top + inset.bottom);
    
    CGSize result = CGSizeZero;
    for (UIView *view in self.subviews)
    {
        view.autoresizingMask = UIViewAutoresizingNone;
        if (![self viewIsScrollbar:view] && !view.hidden)
        {
            CGSize _size = view.frame.size;
            if (self.autoresizesSubviews)
            {
                _size = [view sizeThatFits:size];
                _size.width = size.width;
            }
            if (update) view.frame = CGRectMake(0, result.height, _size.width, _size.height);
            result.height += _size.height + _contentSpacing;
            result.width = MAX(result.width, _size.width);
        }
    }
    
    if (update) self.contentSize = result;
    result.width += inset.left + inset.right;
    result.height = MIN(_maxHeight ?: INFINITY, MAX(0.0f, result.height - _contentSpacing + inset.top + inset.bottom));
    return result;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return [self calculateContentSizeThatFits:size andUpdateLayout:NO];
}

@end
