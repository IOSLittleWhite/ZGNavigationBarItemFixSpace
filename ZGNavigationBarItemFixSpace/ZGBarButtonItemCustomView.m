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
#import "Aspects.h"
#import <KVOController/KVOController.h>

@interface ZGBarButtonItemCustomView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) UIView *customView;
@property (nonatomic, weak) UIView *barView;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.barView = [self p_getBarViewFromView:self];
    [self p_setButtonTitleFollowBarViewTintColor];
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
            __weak typeof(self) weakSelf = self;
            [self.KVOController observe:self.barView
                                keyPath:@"tintColor"
                                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                  block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
                                      [weakSelf.button setTitleColor:weakSelf.barView.tintColor forState:UIControlStateNormal];
                                  }];
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



@interface UINavigationBar (Space)

@end

@implementation UINavigationBar (Space)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self zg_swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews)
                                        swizzledSel:@selector(zg_layoutSubviews)];
    });
}

- (void)zg_layoutSubviews{
    [self zg_layoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        self.layoutMargins = UIEdgeInsetsZero;
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                subView.layoutMargins = UIEdgeInsetsMake(0, 4, 0, 10);
                break;
            }
        }
    }
}

@end


