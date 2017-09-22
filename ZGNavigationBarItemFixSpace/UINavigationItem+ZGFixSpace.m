//
//  UINavigationItem+ZGFixSpace.m
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/20.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import "UINavigationItem+ZGFixSpace.h"
#import "NSObject+ZGRuntime.h"
#import "UIBarButtonItem+ZGFixSpace.h"
#import "ZGNavBarItemSpceMacro.h"

@implementation UINavigationItem (ZGFixSpace)

+ (void)load {
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
//                                    swizzledSel:@selector(zg_setLeftBarButtonItem:)];
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:)
//                                    swizzledSel:@selector(zg_setLeftBarButtonItems:)];
//
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
//                                    swizzledSel:@selector(zg_setRightBarButtonItem:)];
//    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:)
//                                    swizzledSel:@selector(zg_setRightBarButtonItems:)];
}

- (void)zg_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (!leftBarButtonItem || [leftBarButtonItem isKindOfClass:[NSNull class]]) {
        [self zg_setLeftBarButtonItem:nil];
        return;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
        [leftBarButtonItem zg_setPosition:ZGBarButtonItemPositionLeft];
        [self zg_setLeftBarButtonItem:leftBarButtonItem];
    } else {
        [self setLeftBarButtonItems:@[leftBarButtonItem]];
    }
}

- (void)zg_setLeftBarButtonItems:(NSArray *)leftBarButtonItems {
    if (!leftBarButtonItems || [leftBarButtonItems isKindOfClass:[NSNull class]] || leftBarButtonItems.count == 0) {
        [self zg_setLeftBarButtonItems:nil];
        return;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        ZGBarButtonItemCustomView *customView = (ZGBarButtonItemCustomView *)((UIBarButtonItem *)[leftBarButtonItems firstObject]).customView;
        CGFloat gap = ZG_BAR_ITEM_SCREEN_BORDER_GAP;
        if (customView.itemType == ZGBarButtonItemTypeImage) {
            gap -= ZG_BAR_ITEM_LEFT_ICON_EDGE_INSETS;
        }
        [items addObject:[UIBarButtonItem fixedSpaceWithWidth:-(15 - gap)]];
    }
    ZGBarButtonItemCustomView *prevCustomeView = nil;
    for (NSInteger i=0; i<leftBarButtonItems.count; i++) {
        UIBarButtonItem *item = [leftBarButtonItems objectAtIndex:i];
        [item zg_setPosition:ZGBarButtonItemPositionLeft];
        [items addObject:item];
        [item zg_setPrevCustomView:prevCustomeView];
        prevCustomeView = (ZGBarButtonItemCustomView *)item.customView;
    }
    [self zg_setLeftBarButtonItems:items];
}

- (void)zg_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    if (!rightBarButtonItem || [rightBarButtonItem isKindOfClass:[NSNull class]]) {
        [self zg_setRightBarButtonItem:nil];
        return;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
        [rightBarButtonItem zg_setPosition:ZGBarButtonItemPositionRight];
        [self zg_setRightBarButtonItem:rightBarButtonItem];
    } else {
        [self setRightBarButtonItems:@[rightBarButtonItem]];
    }
}

- (void)zg_setRightBarButtonItems:(NSArray *)rightBarButtonItems {
    if (!rightBarButtonItems || [rightBarButtonItems isKindOfClass:[NSNull class]] || rightBarButtonItems.count == 0) {
        [self zg_setRightBarButtonItems:nil];
        return;
    }
    
    NSMutableArray *items = [NSMutableArray array];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        ZGBarButtonItemCustomView *customView = (ZGBarButtonItemCustomView *)((UIBarButtonItem *)[rightBarButtonItems firstObject]).customView;
        CGFloat gap = ZG_BAR_ITEM_SCREEN_BORDER_GAP;
        if (customView.itemType == ZGBarButtonItemTypeImage) {
            gap -= ZG_BAR_ITEM_RIGHT_ICON_EDGE_INSETS;
        }
        [items addObject:[UIBarButtonItem fixedSpaceWithWidth:-(15 - gap)]];
    }
    ZGBarButtonItemCustomView *prevCustomeView = nil;
    for (NSInteger i=0; i<rightBarButtonItems.count; i++) {
        UIBarButtonItem *item = [rightBarButtonItems objectAtIndex:i];
        [item zg_setPosition:ZGBarButtonItemPositionRight];
        [item zg_setPrevCustomView:prevCustomeView];
        prevCustomeView = (ZGBarButtonItemCustomView *)item.customView;
        [items addObject:item];
    }
    [self zg_setRightBarButtonItems:items];
}

@end
