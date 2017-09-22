//
//  ZGBarButtonItemCustomView.h
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/22.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZGBarButtonItemPosition) {
    ZGBarButtonItemPositionLeft,
    ZGBarButtonItemPositionRight
};

typedef NS_ENUM(NSInteger, ZGBarButtonItemType) {
    ZGBarButtonItemTypeTitle,
    ZGBarButtonItemTypeImage,
    ZGBarButtonItemTypeCustomView
};

@interface ZGBarButtonItemCustomView : UIView

@property (nonatomic, assign) ZGBarButtonItemPosition position;
@property (nonatomic, weak) ZGBarButtonItemCustomView *prevCustomView;
@property (nonatomic, assign) ZGBarButtonItemType itemType;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (instancetype)initWithCustomView:(UIView *)customView;

@end
