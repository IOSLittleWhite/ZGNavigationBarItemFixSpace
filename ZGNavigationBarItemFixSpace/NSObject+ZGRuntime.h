//
//  NSObject+ZGRuntime.h
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/21.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZGRuntime)

- (void)zg_swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel;

@end
