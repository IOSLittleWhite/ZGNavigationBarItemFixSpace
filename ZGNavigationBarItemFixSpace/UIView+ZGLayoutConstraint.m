//
//  UIView+ZGLayoutConstraint.m
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/22.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import "UIView+ZGLayoutConstraint.h"

@implementation UIView (ZGLayoutConstraint)

- (void)zg_addSizeConstraintWithSize:(CGSize)size {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:size.width]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:size.height]];
    
}

- (void)zg_addCenterYConstraint {
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0]];
}

- (void)zg_addHorizontalGap:(CGFloat)gap toView:(UIView *)view {
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:view
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:gap]];
}

- (void)zg_addLeftBorderGap:(CGFloat)gap {
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:gap]];
}

- (void)zg_addRightBorderGap:(CGFloat)gap {
    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:gap]];
}

@end
