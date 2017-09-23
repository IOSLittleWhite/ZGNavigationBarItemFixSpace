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

@interface ZGBarButtonItemCustomView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL fixed;
@property (nonatomic, assign) BOOL isLastItem;
@property (nonatomic, weak) UINavigationBar *navBar;

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
        [self addSubview:customView];
        [self setFrame:customView.bounds];
        [self setCenter:customView.center];
        
        [self p_init];
        self.itemType = ZGBarButtonItemTypeCustomView;
    }
    return self;
}

- (void)dealloc {
    [self.navBar removeObserver:self forKeyPath:@"tintColor"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([[UIDevice currentDevice] systemVersion].floatValue < 11) {
        [self p_setTitleFollowNavBarTintColorFromView:self];
        return;
    }
    
    if (self.fixed) {
        return;
    }
    
    UIView *adaptorView = [self p_getAdaptorViewFromView:self];
    UIView *prevAdaptorView = [self p_getAdaptorViewFromView:self.prevCustomView];
    [adaptorView zg_addSizeConstraintWithSize:self.frame.size];
    [adaptorView zg_addCenterYConstraint];
    CGFloat screenBorderGap = ZG_BAR_ITEM_SCREEN_BORDER_GAP;
    
    if (self.position == ZGBarButtonItemPositionLeft) {
        if (!prevAdaptorView) {
            [adaptorView zg_addLeftBorderGap:0];
        } else {
            [prevAdaptorView zg_addHorizontalGap:ZG_BAR_ITEM_GAP toView:adaptorView];
        }
        
        if (self.isLastItem) {
            UIStackView *stackView = [self p_getStackViewFromView:adaptorView];
            for (NSLayoutConstraint *constraint in stackView.superview.constraints) {
                if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]] &&
                    constraint.firstAttribute == NSLayoutAttributeLeading) {
                    [stackView.superview removeConstraint:constraint];
                }
            }
            if (self.itemType == ZGBarButtonItemTypeImage) {
                screenBorderGap -= ZG_BAR_ITEM_LEFT_ICON_EDGE_INSETS;
            }
            [stackView zg_addLeftBorderGap:screenBorderGap];
        }
        
    } else if (self.position == ZGBarButtonItemPositionRight) {
        if (!prevAdaptorView) {
            [adaptorView zg_addRightBorderGap:0];
        } else {
            [adaptorView zg_addHorizontalGap:-ZG_BAR_ITEM_GAP toView:prevAdaptorView];
        }
        
        if (self.isLastItem) {
            UIStackView *stackView = [self p_getStackViewFromView:adaptorView];
            for (NSLayoutConstraint *constraint in stackView.superview.constraints) {
                if ([constraint.firstItem isKindOfClass:[UILayoutGuide class]] &&
                    constraint.firstAttribute == NSLayoutAttributeTrailing) {
                    [stackView.superview removeConstraint:constraint];
                }
            }
            if (self.itemType == ZGBarButtonItemTypeImage) {
                screenBorderGap -= ZG_BAR_ITEM_RIGHT_ICON_EDGE_INSETS;
            }
            [stackView zg_addRightBorderGap:-screenBorderGap];
        }
    }
    
    [self p_setTitleFollowNavBarTintColorFromView:adaptorView];
    self.fixed = YES;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self.button setTitleColor:self.navBar.tintColor forState:UIControlStateNormal];
}

#pragma mark - private
- (void)p_init {
    self.isLastItem = YES;
    self.fixed = NO;
    self.position = ZGBarButtonItemPositionLeft;
}

- (void)p_setUpButtonWithTitle:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action {
    [self setButton:[[UIButton alloc] init]];
    [self addSubview:self.button];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button setTintColor:[UIColor blueColor]];
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button.titleLabel setFont:ZG_BAR_ITEM_FONT];
    if (image.renderingMode == UIImageRenderingModeAutomatic) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [self.button setImage:image forState:UIControlStateNormal];
    [self.button sizeToFit];
    [self.button setFrame:CGRectMake(0, 0, MAX(self.button.frame.size.width, ZG_BAR_ITEM_MIN_WIDTH), 44)];
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self setFrame:self.button.bounds];
}

- (UIView *)p_getAdaptorViewFromView:(UIView *)view {
    if (!view) {
        return nil;
    }
    UIView *tempView = view;
    while (![tempView isKindOfClass:NSClassFromString(@"_UITAMICAdaptorView")] && tempView.superview) {
        tempView = tempView.superview;
    }
    return tempView;
}

- (UIStackView *)p_getStackViewFromView:(UIView *)view {
    if (!view) {
        return nil;
    }
    UIView *tempView = view;
    while (![tempView isKindOfClass:UIStackView.class] && tempView.superview) {
        tempView = tempView.superview;
    }
    return (UIStackView *)tempView;
}

- (UINavigationBar *)p_getNavBarViewFromView:(UIView *)view {
    if (!view) {
        return nil;
    }
    UIView *tempView = view;
    while (![tempView isKindOfClass:UINavigationBar.class] && tempView.superview) {
        tempView = tempView.superview;
    }
    return (UINavigationBar *)tempView;
}

- (void)p_setTitleFollowNavBarTintColorFromView:(UIView *)view {
    if (self.itemType == ZGBarButtonItemTypeTitle) {
        self.navBar = [self p_getNavBarViewFromView:view];
        [self.button setTitleColor:self.navBar.tintColor forState:UIControlStateNormal];
        
        [self.navBar addObserver:self
                      forKeyPath:@"tintColor"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:nil];
    }
}

#pragma mark - setter & getter
- (void)setPosition:(ZGBarButtonItemPosition)position {
    _position = position;
    
    if (self.position == ZGBarButtonItemPositionLeft) {
        [self.button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    } else {
        [self.button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
}

- (void)setPrevCustomView:(ZGBarButtonItemCustomView *)prevCustomView {
    _prevCustomView = prevCustomView;
    self.prevCustomView.isLastItem = NO;
}

@end
