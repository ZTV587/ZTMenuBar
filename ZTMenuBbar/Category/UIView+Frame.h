//
//  Created by zZT on 15/4/28.
//  Copyright © 2015年 ZZT. All rights reserved.
//

#import <UIKit/UIKit.h>

// @property 分类.只会生成get,set方法声明,不会生成get,set方法实现,不会生成下划线成员属性/变量

// 通常经常使用的方法,最好加前缀
@interface UIView (Frame)

@property CGFloat ZT_x;
@property CGFloat ZT_y;
@property CGFloat ZT_centerX;
@property CGFloat ZT_centerY;
@property CGFloat ZT_height;
@property CGFloat ZT_width;

@end
