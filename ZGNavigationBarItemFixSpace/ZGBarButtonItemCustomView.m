//
//  ZGBarButtonItemCustomView.m
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/22.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import "ZGBarButtonItemCustomView.h"
#import "UIView+ZGLayoutConstraint.h"
#import "ZGNavBarItemSpceMacro.h"
#import "NSObject+ZGRuntime.h"

@interface ZGBarButtonItemCustomView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UIView *customView;
@property (nonatomic, weak) UIView *barView;
@property (nonatomic, weak) UIView *stackView;

@end

@implementation ZGBarButtonItemCustomView

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    if (self = [super init]) {
        [self p_setUpButtonWithTitle:title
                               image:nil
                              target:target
                              action:action];
        [self p_init];
        self.itemType = ZGBarButtonItemTypeTitle;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    if (self = [super init]) {
        [self p_setUpButtonWithTitle:nil
                               image:image
                              target:target
                              action:action];
        [self p_init];
        self.itemType = ZGBarButtonItemTypeImage;
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    if (self = [super init]) {
        self.customView = customView;
        [self addSubview:self.button];
        [self.button setFrame:CGRectMake(0, 0, MAX(self.customView.frame.size.width, ZG_BAR_ITEM_MIN_WIDTH), 44)];
        [self setFrame:self.button.bounds];
        
        [self addSubview:self.customView];
        self.customView.center = self.center;
        
        [self p_init];
        self.itemType = ZGBarButtonItemTypeCustomView;
    }
    return self;
}

- (void)dealloc {
    if (self.itemType == ZGBarButtonItemTypeTitle && [self.barView isKindOfClass:[UINavigationBar class]]) {
        [self.barView removeObserver:self forKeyPath:@"tintColor"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.barView = [self p_getBarViewFromView:self];
    [self p_setButtonTitleFollowBarViewTintColor];
}

- (BOOL)isFixedForStackView:(UIView *)stackView {
    if (stackView == self.stackView) {
        return YES;
    } else {
        self.stackView = stackView;
        return NO;
    }
}

#pragma mark - actions
- (void)doAction {
    if (self.target && [self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action
                            onThread:[NSThread currentThread]
                          withObject:self.barButtonItem
                       waitUntilDone:YES];
    }
}

#pragma mark - Notice
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.button setTitleColor:self.barView.tintColor forState:UIControlStateNormal];
}

#pragma mark - private
- (void)p_init {
    _position = ZGBarButtonItemPositionLeft;
    self.clipsToBounds = YES;
}

- (void)p_setUpButtonWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action {
    [self addSubview:self.button];
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button.titleLabel setFont:ZG_BAR_ITEM_FONT];
    if (image.renderingMode == UIImageRenderingModeAutomatic) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [self.button setImage:image forState:UIControlStateNormal];
    [self.button sizeToFit];
    [self.button setFrame:CGRectMake(0, 0, MAX(self.button.frame.size.width, ZG_BAR_ITEM_MIN_WIDTH), 44)];
    [self setFrame:self.button.bounds];
    [self setTarget:target];
    [self setAction:action];
}

- (UIView *)p_getBarViewFromView:(UIView *)view {
    UIView *tempView = view;
    while (![tempView isKindOfClass:UINavigationBar.class] && ![tempView isKindOfClass:UIToolbar.class] && tempView.superview) {
        tempView = tempView.superview;
    }
    if (tempView == view) {
        return nil;
    }
    return tempView;
}

- (void)p_setButtonTitleFollowBarViewTintColor {
    if (self.itemType == ZGBarButtonItemTypeTitle) {
        [self.button setTitleColor:self.barView.tintColor forState:UIControlStateNormal];
        
        if ([self.barView isKindOfClass:UINavigationBar.class]) {
            [self.barView addObserver:self
                          forKeyPath:@"tintColor"
                             options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                             context:nil];
        }
    }
}

#pragma mark - setter & getter
- (void)setPosition:(ZGBarButtonItemPosition)position {
    _position = position;
    
    if (self.position == ZGBarButtonItemPositionLeft) {
        [self.button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.customView.center = CGPointMake(self.customView.frame.size.width/2, self.customView.center.y);
    } else {
        [self.button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        self.customView.center = CGPointMake(self.frame.size.width-self.customView.frame.size.width/2, self.customView.center.y);
    }
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button addTarget:self
                    action:@selector(doAction)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end

#pragma mark - UIStackView + Space
@interface UIStackView (Space)



@end

@implementation UIStackView (Space)

- (void)layoutSubviews {
    if ([self isKindOfClass:NSClassFromString(@"_UIButtonBarStackView")]) {
        UIView *adaptorView = [self.subviews firstObject];
        ZGBarButtonItemCustomView *customView = (ZGBarButtonItemCustomView *)[adaptorView.subviews firstObject];
        if ([customView isFixedForStackView:self]) {
            return;
        }
        if (customView && [customView isKindOfClass:[ZGBarButtonItemCustomView class]]) {
            
            if (customView.position == ZGBarButtonItemPositionLeft) {
                // borderGap
                for (NSLayoutConstraint *constraint in self.superview.constraints) {
                    if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]] &&
                        constraint.firstAttribute == NSLayoutAttributeLeading) {
                        [self.superview removeConstraint:constraint];
                    }
                }
                CGFloat screenBorderGap = ZG_BAR_ITEM_SCREEN_BORDER_GAP;
                if (customView.itemType == ZGBarButtonItemTypeImage) {
                    screenBorderGap -= ZG_BAR_ITEM_LEFT_ICON_EDGE_INSETS;
                }
                [self zg_addLeftBorderGap:screenBorderGap];
                // itemGap
                [adaptorView zg_addLeftBorderGap:0];
                do {
                    [adaptorView zg_addSizeConstraintWithSize:customView.frame.size];
                    [adaptorView zg_addCenterYConstraint];
                    [adaptorView zg_addHorizontalGap:ZG_BAR_ITEM_GAP toView:customView.nextCustomView.superview];
                    customView = customView.nextCustomView;
                    adaptorView = customView.superview;
                } while (adaptorView);
                
            } else if (customView.position == ZGBarButtonItemPositionRight) {
                // itemGap
                do {
                    [adaptorView zg_addSizeConstraintWithSize:customView.frame.size];
                    [adaptorView zg_addCenterYConstraint];
                    [adaptorView zg_addHorizontalGap:ZG_BAR_ITEM_GAP toView:customView.prevCustomView.superview];
                    customView = customView.prevCustomView;
                    adaptorView = customView.superview;
                } while (adaptorView);
                [adaptorView zg_addRightBorderGap:0];
                
                // borderGap
                for (NSLayoutConstraint *constraint in self.superview.constraints) {
                    if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]] &&
                        constraint.firstAttribute == NSLayoutAttributeTrailing) {
                        [self.superview removeConstraint:constraint];
                    }
                }
                CGFloat screenBorderGap = ZG_BAR_ITEM_SCREEN_BORDER_GAP;
                if (customView.itemType == ZGBarButtonItemTypeImage) {
                    screenBorderGap -= ZG_BAR_ITEM_RIGHT_ICON_EDGE_INSETS;
                }
                [self zg_addRightBorderGap:-screenBorderGap];
            }
        }
    }
    [super layoutSubviews];
}

@end
