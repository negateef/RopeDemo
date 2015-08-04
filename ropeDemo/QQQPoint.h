//
//  QQQPoint.h
//  ropeDemo
//
//  Created by Misha Babenko on 8/4/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QQQPoint : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;


- (instancetype)initWithX:(CGFloat)x andY:(CGFloat)y;

/**
 *  Returns Euclidian distance between two points
 */
- (double)distanceToPoint:(QQQPoint *)point;

@end
