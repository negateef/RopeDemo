//
//  Rope.h
//  ropeDemo
//
//  Created by Misha Babenko on 7/29/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QQQPoint : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;


- (instancetype)initWithX:(CGFloat)x andY:(CGFloat)y;
- (double)distanceToPoint:(QQQPoint *)point;

@end

@interface QQQRope : NSObject

@property (nonatomic, strong) NSMutableArray *points;

- (void)movePointAtIndex:(NSInteger)index toPoint:(QQQPoint *)newPoint;

@end
