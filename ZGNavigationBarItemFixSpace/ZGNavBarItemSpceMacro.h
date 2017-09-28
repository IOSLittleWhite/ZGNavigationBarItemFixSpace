//
//  ZGNavBarItemSpceMacro.h
//  ZGFinance
//
//  Created by JZ_Stone on 2017/9/22.
//  Copyright © 2017年 Zhugelicai. All rights reserved.
//

#ifndef ZGNavBarItemSpceMacro_h
#define ZGNavBarItemSpceMacro_h

#define ZG_BAR_ITEM_SCREEN_BORDER_GAP           10  // item到屏幕边缘的距离
#define ZG_BAR_ITEM_GAP                         5   // item之间的距离 ios11以后生效
#define ZG_BAR_ITEM_LEFT_ICON_EDGE_INSETS       6   // 左边item图标图片内边距
#define ZG_BAR_ITEM_RIGHT_ICON_EDGE_INSETS      2   // 右边item图标图片内边距
#define ZG_BAR_ITEM_MIN_WIDTH                   44  // item的最小宽度
#define ZG_BAR_ITEM_FONT                        [UIFont systemFontOfSize:15 weight:UIFontWeightLight] // item字体 ios11以后生效


#endif /* ZGNavBarItemSpceMacro_h */

/*
 版本1.2
 2017-09-27
 1. 替换UIBarButtonItem原生实例化方法initWithBarButtonSystemItem:target:action:
 2. 替换UIBarButtonItem原生的setTarget: 和 setAction: 方法
 
 版本1.1
 2017-09-26
 1. 增加UIBarButtonItem被添加到UIToolbar上的处理；
 2. 增加对UIBarButtonItem的UIBarButtonItemStyleDone类型的解析；
 
 */
