//
//  YIEdgePanGestureRecognizer.h
//  YIEdgePanGestureRecognizer
//
//  Created by Inami Yasuhiro on 12/11/29.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YIEdgePanGestureRecognizerFirstTouchAreaNone    = 0,
    YIEdgePanGestureRecognizerFirstTouchAreaLeft    = 1 << 0,
    YIEdgePanGestureRecognizerFirstTouchAreaRight   = 1 << 1,
    YIEdgePanGestureRecognizerFirstTouchAreaBottom  = 1 << 2,
    YIEdgePanGestureRecognizerFirstTouchAreaTop     = 1 << 3
} YIEdgePanGestureRecognizerFirstTouchArea;


@interface YIEdgePanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic, readonly) CGPoint firstTouchLocation;
@property (nonatomic, readonly) YIEdgePanGestureRecognizerFirstTouchArea firstTouchArea;

@end
