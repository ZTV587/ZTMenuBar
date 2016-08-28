//
//  Created by zZT on 15/4/28.
//  Copyright © 2015年 ZZT. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setZT_centerX:(CGFloat)ZT_centerX
{
    CGPoint center = self.center;
    center.x = ZT_centerX;
    self.center = center;
}

- (CGFloat)ZT_centerX
{
    return self.center.x;
}

- (void)setZT_centerY:(CGFloat)ZT_centerY
{
    CGPoint center = self.center;
    center.y = ZT_centerY;
    self.center = center;
}

- (CGFloat)ZT_centerY
{
    return self.center.y;
}

- (void)setZT_x:(CGFloat)ZT_x
{
    CGRect frame = self.frame;
    frame.origin.x = ZT_x;
    self.frame = frame;
}

- (CGFloat)ZT_x
{
    return self.frame.origin.x;
}

- (void)setZT_y:(CGFloat)ZT_y
{
    CGRect frame = self.frame;
    frame.origin.y = ZT_y;
    self.frame = frame;
}

- (CGFloat)ZT_y
{
    return self.frame.origin.y;
}

- (void)setZT_width:(CGFloat)ZT_width
{
    CGRect frame = self.frame;
    frame.size.width = ZT_width;
    self.frame = frame;
}
- (CGFloat)ZT_width
{
    return self.frame.size.width;
}

- (void)setZT_height:(CGFloat)ZT_height
{
    CGRect frame = self.frame;
    frame.size.height = ZT_height;
    self.frame = frame;
}

- (CGFloat)ZT_height
{
    return self.frame.size.height;
}
@end
