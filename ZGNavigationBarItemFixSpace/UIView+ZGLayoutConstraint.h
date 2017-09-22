//
//  UIView+ZGLayoutConstraint.h
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/22.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZGLayoutConstraint)

- (void)zg_addSizeConstraintWithSize:(CGSize)size;
- (void)zg_addCenterYConstraint;
- (void)zg_addHorizontalGap:(CGFloat)gap toView:(UIView *)view;
- (void)zg_addLeftBorderGap:(CGFloat)gap;
- (void)zg_addRightBorderGap:(CGFloat)gap;

@end
