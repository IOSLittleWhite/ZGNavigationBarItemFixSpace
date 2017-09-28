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

@end
