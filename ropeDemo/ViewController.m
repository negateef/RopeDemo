//
//  ViewController.m
//  ropeDemo
//
//  Created by Misha Babenko on 7/29/15.
//  Copyright (c) 2015 Misha Babenko. All rights reserved.
//

#import "ViewController.h"
#import "QQQRope.h"

static const CGFloat kRadius = 2.0f;
static const CGFloat kMaxDistance = 50.0f;

@interface ViewController ()

@property (nonatomic, strong) QQQRope *rope;
@property (nonatomic, strong) NSMutableArray *pointsViews;

@property (nonatomic, strong) NSMutableArray *movePointsArray;
@property (nonatomic, assign) NSInteger currentPosition;


@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rope = [[QQQRope alloc] init];
    self.pointsViews = [[NSMutableArray alloc] init];
    self.movePointsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.rope.points.count; i++) {
        QQQPoint *point = self.rope.points[i];
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 2 * kRadius, 2 * kRadius)];
        pointView.layer.cornerRadius = kRadius;
        pointView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
        [self.view addSubview:pointView];
        [self.pointsViews addObject:pointView];
    }
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
    [self.view addGestureRecognizer:recognizer];
    
}

#pragma mark - Actions

- (void)gestureRecognized:(UITapGestureRecognizer *)recognizer {
    
    CGPoint tempPoint = [recognizer locationInView:self.view];
    QQQPoint *point = [[QQQPoint alloc] initWithX:tempPoint.x andY:tempPoint.y];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"Began!");
        self.currentPosition = [self closestPointInRopeToPoint:point];
        CGFloat distance = [point distanceToPoint:self.rope.points[self.currentPosition]];
        
        if (distance > kMaxDistance)
            self.currentPosition = -1;
        
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"Ended!");
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"Changed!");
        
        if (self.currentPosition == -1)
            return;
        
        
        [self smallUpdatedPointWithIndex:self.currentPosition toPoint:point];
        
        return;
    }
}

#pragma mark - Helper methods

- (NSInteger)closestPointInRopeToPoint:(QQQPoint *)point {
    NSInteger result = 0;
    for (NSInteger i = 0; i < self.rope.points.count; i++) {
        CGFloat dist1 = [point distanceToPoint:self.rope.points[i]];
        CGFloat dist2 = [point distanceToPoint:self.rope.points[result]];        
        if (dist1 < dist2)
            result = i;
    }
    
    return result;
}


- (void)smallUpdatedPointWithIndex:(NSInteger)index toPoint:(QQQPoint *)point {
    
    [self.rope movePointAtIndex:index toPoint:point];
    for (int i = 0; i < self.rope.points.count; i++) {
        UIView *view = self.pointsViews[i];
        QQQPoint *point = self.rope.points[i];

        
        view.frame = CGRectMake(point.x, point.y, 2 * kRadius, 2 * kRadius);
    }    
}

@end
