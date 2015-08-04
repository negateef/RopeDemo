//
//  Rope.m
//  ropeDemo
//
//  Created by Misha Babenko on 7/29/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import "QQQRope.h"

static const NSInteger numberOfPoints = 500;
static const CGFloat kDecrease = 0.9995f;
static const CGFloat kPercentageEndOfRope = 0.05f;

@interface QQQRope ()

@property (nonatomic, assign) CGFloat lengthBetweenPoints;
@property (nonatomic, strong) NSMutableArray *usedPoint;

@end

@implementation QQQRope

#define EPS 1e-1

- (instancetype)init {
    if (self = [super init]) {
        CGFloat left = 10.0, right = 350.0;
        self.points = [[NSMutableArray alloc] init];
        for (int i = 0; i < numberOfPoints - 1; i++) {
            CGFloat x = left + ((right - left) / numberOfPoints) * i;
            CGFloat y = 600;
            
            QQQPoint *point = [[QQQPoint alloc] initWithX:x andY:y];
            [self.points addObject:point];
        }
        
        self.lengthBetweenPoints = [self.points[1] x] - [self.points[0] x];
        
        
        for (int i = 0; i < numberOfPoints - 1; i++) {
            double x = right;
            double y = 600 - i * self.lengthBetweenPoints;
            
            QQQPoint *point = [[QQQPoint alloc] init];
            point.x = x;
            point.y = y;
            
            [self.points addObject:point];
        }
        
        for (int i = 0; i < numberOfPoints - 1; i++) {
            double x = right - i * self.lengthBetweenPoints;
            double y = 600 - numberOfPoints * self.lengthBetweenPoints;
            
            QQQPoint *point = [[QQQPoint alloc] init];
            point.x = x;
            point.y = y;
            
            [self.points addObject:point];
        }
        
        for (int i = 0; i < numberOfPoints - 1; i++) {
            double x = left;
            double y = (600 - numberOfPoints * self.lengthBetweenPoints) + i * self.lengthBetweenPoints;
            
            QQQPoint *point = [[QQQPoint alloc] init];
            point.x = x;
            point.y = y;
            
            [self.points addObject:point];
        }
        self.usedPoint = [[NSMutableArray alloc] initWithCapacity:self.points.count];
        for (int i = 0; i < self.points.count; i++)
            self.usedPoint[i] = @(NO);
        
    }
    
    
    
    
    return self;
}

- (void)movePointAtIndex:(NSInteger)index toPoint:(QQQPoint *)newPoint {
    for (int i = 0; i < self.points.count; i++)
        self.usedPoint[i] = @(NO);
    CGFloat friction = 1.0;
    if (index < self.points.count * kPercentageEndOfRope || index > self.points.count - self.points.count * kPercentageEndOfRope)
        friction = 0.5;
    
    NSLog (@"%lu %lu", index, self.points.count);
    [self updatePointWithIndex:index toPoint:newPoint friction:friction];
}

- (void)updatePointWithIndex:(NSInteger)index
                     toPoint:(QQQPoint *)newPoint
                    friction:(CGFloat)friction {
    
    if ([self.usedPoint[index] boolValue])
        return;
    
    self.usedPoint[index] = @(YES);
    
    if ([newPoint distanceToPoint:self.points[index]] < EPS)
        return;
    
    QQQPoint *oldPoint = self.points[index];
    
    self.points[index] = newPoint;
    QQQPoint *left = nil;
    QQQPoint *right = nil;
    if (index) {
        NSInteger tempIndex = index - 1;
        left = [self computePointAtIndex:tempIndex
                         relativeToPoint:newPoint
                                oldPoint:oldPoint
                                friction:friction];
        
        [self updatePointWithIndex:tempIndex
                           toPoint:left
                          friction:friction * kDecrease];
    }
    if (index != self.points.count - 1) {
        NSInteger tempIndex = index + 1;
        right = [self computePointAtIndex:tempIndex
                          relativeToPoint:newPoint
                                 oldPoint:oldPoint
                                 friction:friction];
        
        [self updatePointWithIndex:tempIndex
                           toPoint:right
                          friction:friction * kDecrease];
    }
}

- (QQQPoint *)computePointAtIndex:(NSInteger)index
                  relativeToPoint:(QQQPoint *)point
                         oldPoint:(QQQPoint *)oldPoint
                         friction:(CGFloat)friction {
    
    CGFloat xA = point.x, yA = point.y;
    CGFloat xC = [self.points[index] x], yC = [self.points[index] y];
    
    xC += friction * (point.x - oldPoint.x);
    yC += friction * (point.y - oldPoint.y);
    
    
    CGFloat r = self.lengthBetweenPoints;
    
    CGFloat lenAC = sqrt((xA - xC) * (xA - xC) + (yA - yC) * (yA - yC));
    CGFloat k = r / lenAC;
    
    CGFloat x = xA + (xC - xA) * k;
    CGFloat y = yA + (yC - yA) * k;
    
    QQQPoint *result = [[QQQPoint alloc] initWithX:x andY:y];
    return result;
}

@end
