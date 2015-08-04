//
//  QQQPoint.m
//  ropeDemo
//
//  Created by Misha Babenko on 8/4/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import "QQQPoint.h"

@implementation QQQPoint

- (instancetype)initWithX:(CGFloat)x andY:(CGFloat)y {
    if (self = [super init]) {
        _x = x;
        _y = y;
    }
    return self;
}

- (CGFloat)distanceToPoint:(QQQPoint *)point {
    return sqrt((point.x - self.x) * (point.x - self.x) + (point.y - self.y) * (point.y - self.y));
}

@end