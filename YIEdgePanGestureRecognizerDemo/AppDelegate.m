//
//  AppDelegate.m
//  YIEdgePanGestureRecognizerDemo
//
//  Created by Inami Yasuhiro on 12/11/29.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import "AppDelegate.h"
#import "YIEdgePanGestureRecognizer.h"

@implementation AppDelegate
{
    UIView* _overlayView;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    YIEdgePanGestureRecognizer* edgePanGesture = [[YIEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanGesture:)];
    
#if 1
    // add to window (+20 for status-bar-height)
    edgePanGesture.edgeInsets = UIEdgeInsetsMake(40+20, 40, 40, 40);
    [self.window addGestureRecognizer:edgePanGesture];
#else
    // add to view
    edgePanGesture.edgeInsets = UIEdgeInsetsMake(40, 40, 40, 40);
    [self.window.rootViewController.view addGestureRecognizer:edgePanGesture];
#endif
    
    _overlayView = [[UIView alloc] initWithFrame:self.window.bounds];
    _overlayView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    return YES;
}

- (void)setOverlayViewY:(CGFloat)y
{
    CGRect frame;
    frame = _overlayView.frame;
    frame.origin.y = y;
    _overlayView.frame = frame;
}

- (void)handleEdgePanGesture:(YIEdgePanGestureRecognizer*)gesture
{
    NSLog(@"state = %d",gesture.state);
    
    // NOTE: this demo only shows swipe-up overlay
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"--------------------");
            NSLog(@"firstTouchLocation = %@",NSStringFromCGPoint(gesture.firstTouchLocation));
            NSLog(@"firstTouchArea = %d",gesture.firstTouchArea);
            
            [self setOverlayViewY:self.window.bounds.size.height];
            
            [self.window addSubview:_overlayView];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self setOverlayViewY:[gesture locationInView:gesture.view].y];
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"firstTouchLocation = %@",NSStringFromCGPoint(gesture.firstTouchLocation));
            NSLog(@"firstTouchArea = %d",gesture.firstTouchArea);
            NSLog(@"--------------------");
            
            [UIView animateWithDuration:0.5 animations:^{
                
                [self setOverlayViewY:self.window.bounds.size.height];
                
            } completion:^(BOOL finished) {
                
                [_overlayView removeFromSuperview];
                
            }];
            break;
        }
        default:
            break;
    }
}

@end
