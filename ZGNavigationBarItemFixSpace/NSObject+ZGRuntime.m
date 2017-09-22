//
//  NSObject+ZGRuntime.m
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/21.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import "NSObject+ZGRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (ZGRuntime)

- (void)zg_swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel {
    Method m1 = class_getInstanceMethod([self class], originSel);
    Method m2 = class_getInstanceMethod([self class], swizzledSel);
    method_exchangeImplementations(m1, m2);
}

@end
