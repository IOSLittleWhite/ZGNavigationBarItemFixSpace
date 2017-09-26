//
//  UIBarButtonItem+ZGFixSpace.h
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/21.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGBarButtonItemCustomView.h"

@interface UIBarButtonItem (ZGFixSpace)

/*
 *  used before iOS 11
 */
+ (UIBarButtonItem *)zg_fixedSpaceWithWidth:(CGFloat)width;

/*
 *  the side the item be added in (left or right)
 *  used after iOS 11
 */
- (void)zg_setPosition:(ZGBarButtonItemPosition)position;

/*
 *  is the first itme at the current side
 *  used after iOS 11
 */
- (void)zg_setPrevCustomView:(ZGBarButtonItemCustomView *)prevCustomView;

@end
