//
//  Rope.h
//  ropeDemo
//
//  Created by Misha Babenko on 7/29/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QQQPoint.h"

@interface QQQRope : NSObject

@property (nonatomic, strong) NSMutableArray *points;

- (void)movePointAtIndex:(NSInteger)index toPoint:(QQQPoint *)newPoint;

@end
