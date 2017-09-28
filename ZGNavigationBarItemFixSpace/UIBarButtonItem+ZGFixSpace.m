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

+ (UIBarButtonItem *)zg_fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *spaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    spaceBarButton.width = width;
    return spaceBarButton;
}

+ (void)load {
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithTitle:style:target:action:)
                                    swizzledSel:@selector(zg_initWithTitle:style:target:action:)];
    
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithImage:style:target:action:)
                                    swizzledSel:@selector(zg_initWithImage:style:target:action:)];
    
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithBarButtonSystemItem:target:action:)
                                    swizzledSel:@selector(zg_initWithBarButtonSystemItem:target:action:)];
    
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(initWithCustomView:)
                                    swizzledSel:@selector(zg_initWithCustomView:)];
    
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setTarget:)
                                    swizzledSel:@selector(zg_setTarget:)];
    [self zg_swizzleInstanceMethodWithOriginSel:@selector(setAction:)
                                    swizzledSel:@selector(zg_setAction:)];
}

- (void)zg_setTarget:(id)target {
    ZGBarButtonItemCustomView *zgCustomView = (ZGBarButtonItemCustomView *)self.customView;
    zgCustomView.target = target;
    zgCustomView.barButtonItem = self;
}

- (void)zg_setAction:(SEL)action {
    ZGBarButtonItemCustomView *zgCustomView = (ZGBarButtonItemCustomView *)self.customView;
    zgCustomView.action = action;
    zgCustomView.barButtonItem = self;
}

- (instancetype)zg_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    if (!title && style == UIBarButtonItemStyleDone) {
        title = NSLocalizedStringFromTable(@"done", @"ZGBarButtonTitle", nil);
    }
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

- (instancetype)zg_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(nullable id)target action:(nullable SEL)action {
    NSString *title = nil;
    UIImage *image = nil;
    switch (systemItem) {
        case UIBarButtonSystemItemDone:
            title = NSLocalizedStringFromTable(@"done", @"ZGBarButtonTitle", nil);
            break;
            
        case UIBarButtonSystemItemCancel:
            title = NSLocalizedStringFromTable(@"cancel", @"ZGBarButtonTitle", nil);
            break;
            
        case UIBarButtonSystemItemEdit:
            title = NSLocalizedStringFromTable(@"edit", @"ZGBarButtonTitle", nil);
            break;
            
        case UIBarButtonSystemItemSave:
            title = NSLocalizedStringFromTable(@"save", @"ZGBarButtonTitle", nil);
            break;
            
        case UIBarButtonSystemItemAdd:
            image = [UIImage imageNamed:@"zg_bar_icon_add"];
            break;
            
        case UIBarButtonSystemItemCompose:
            image = [UIImage imageNamed:@"zg_bar_icon_compose"];
            break;
            
        case UIBarButtonSystemItemReply:
            image = [UIImage imageNamed:@"zg_bar_icon_reply"];
            break;
            
        case UIBarButtonSystemItemAction:
            image = [UIImage imageNamed:@"zg_bar_icon_action"];
            break;
            
        case UIBarButtonSystemItemOrganize:
            image = [UIImage imageNamed:@"zg_bar_icon_organize"];
            break;
            
        case UIBarButtonSystemItemBookmarks:
            image = [UIImage imageNamed:@"zg_bar_icon_bookmarks"];
            break;
            
        case UIBarButtonSystemItemSearch:
            image = [UIImage imageNamed:@"zg_bar_icon_search"];
            break;
            
        case UIBarButtonSystemItemRefresh:
            image = [UIImage imageNamed:@"zg_bar_icon_refresh"];
            break;
            
        case UIBarButtonSystemItemStop:
            image = [UIImage imageNamed:@"zg_bar_icon_stop"];
            break;
            
        case UIBarButtonSystemItemCamera:
            image = [UIImage imageNamed:@"zg_bar_icon_camera"];
            break;
            
        case UIBarButtonSystemItemTrash:
            image = [UIImage imageNamed:@"zg_bar_icon_trash"];
            break;
            
        case UIBarButtonSystemItemPlay:
            image = [UIImage imageNamed:@"zg_bar_icon_play"];
            break;
            
        case UIBarButtonSystemItemPause:
            image = [UIImage imageNamed:@"zg_bar_icon_pause"];
            break;
            
        case UIBarButtonSystemItemRewind:
            image = [UIImage imageNamed:@"zg_bar_icon_rewind"];
            break;
            
        case UIBarButtonSystemItemFastForward:
            image = [UIImage imageNamed:@"zg_bar_icon_fast_forward"];
            break;
            
        case UIBarButtonSystemItemUndo:
            title = NSLocalizedStringFromTable(@"undo", @"ZGBarButtonTitle", nil);
            break;
            
        case UIBarButtonSystemItemRedo:
            title = NSLocalizedStringFromTable(@"redo", @"ZGBarButtonTitle", nil);
            break;
            
        default:
            break;
    }
    
    if (image) {
        ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithImage:image
                                                                                            target:target
                                                                                            action:action];
        return [self zg_initWithCustomView:zgCustomView];
    } else if (title) {
        ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithTitle:title
                                                                                            target:target
                                                                                            action:action];
        return [self zg_initWithCustomView:zgCustomView];
    } else {
        return [self zg_initWithBarButtonSystemItem:systemItem target:target action:action];
    }
}

- (instancetype)zg_initWithCustomView:(UIView *)customView {
    ZGBarButtonItemCustomView *zgCustomView = [[ZGBarButtonItemCustomView alloc] initWithCustomView:customView];
    return [self zg_initWithCustomView:zgCustomView];
}

@end
