//
//  UIBarButtonItem+ZGFixSpace.m
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/21.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import "UIBarButtonItem+ZGFixSpace.h"
#import "NSObject+ZGRuntime.h"

@implementation UIBarButtonItem (ZGFixSpace)

+ (UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *spaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    spaceBarButton.width = width;
    return spaceBarButton;
}

+ (void)load {
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithTitle:style:target:action:)
//                                    swizzledSel:@selector(zg_initWithTitle:style:target:action:)];
//    
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithImage:style:target:action:)
//                                    swizzledSel:@selector(zg_initWithImage:style:target:action:)];
//    
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithCustomView:)
//                                    swizzledSel:@selector(zg_initWithCustomView:)];
}

- (void)zg_setPosition:(ZGBarButtonItemPosition)position {
    ZGBarButtonItemCustomView *zgCustomView = (ZGBarButtonItemCustomView *)self.customView;
    zgCustomView.position = position;
}

- (void)zg_setPrevCustomView:(ZGBarButtonItemCustomView *)prevCustomView {
    ZGBarButtonItemCustomView *zgCustomView = (ZGBarButtonItemCustomView *)self.customView;
    zgCustomView.prevCustomView = prevCustomView;
}

- (instancetype)zg_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithTitle:title
                                                                                        target:target
                                                                                        action:action];
    return [self zg_initWithCustomView:zgCustomView];
}

- (instancetype)zg_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithImage:image
                                                                                        target:target
                                                                                        action:action];
    return [self zg_initWithCustomView:zgCustomView];
}

- (instancetype)zg_initWithCustomView:(UIView *)customView {
    ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithCustomView:customView];
    return [self zg_initWithCustomView:zgCustomView];
}

@end
