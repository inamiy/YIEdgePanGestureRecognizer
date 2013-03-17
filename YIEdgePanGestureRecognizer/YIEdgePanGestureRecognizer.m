//
//  YIEdgePanGestureRecognizer.m
//  YIEdgePanGestureRecognizer
//
//  Created by Inami Yasuhiro on 12/11/29.
//  Copyright (c) 2012年 Yasuhiro Inami. All rights reserved.
//

#import "YIEdgePanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@implementation YIEdgePanGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] == [[event allTouches] count]) {
        
        CGPoint location = [self locationInView:self.view];
        
        BOOL isTouchingEdge = CGRectContainsPoint(self.view.bounds, location) &&
        !CGRectContainsPoint(UIEdgeInsetsInsetRect(self.view.bounds, self.edgeInsets), location);
        
        if (isTouchingEdge) {
            _firstTouchLocation = location;
            _firstTouchArea = YIEdgePanGestureRecognizerFirstTouchAreaNone;
            
            CGRect edgeFrame;
            
            // left edge
            edgeFrame = self.view.bounds;
            edgeFrame.size.width = self.edgeInsets.left;
            if (CGRectContainsPoint(edgeFrame, _firstTouchLocation)) {
                _firstTouchArea |= YIEdgePanGestureRecognizerFirstTouchAreaLeft;
            }
            
            // right edge
            edgeFrame = self.view.bounds;
            edgeFrame.size.width = self.edgeInsets.right;
            edgeFrame.origin.x = self.view.bounds.size.width-self.edgeInsets.right;
            if (CGRectContainsPoint(edgeFrame, _firstTouchLocation)) {
                _firstTouchArea |= YIEdgePanGestureRecognizerFirstTouchAreaRight;
            }
            
            // bottom edge
            edgeFrame = self.view.bounds;
            edgeFrame.size.height = self.edgeInsets.bottom;
            edgeFrame.origin.y = self.view.bounds.size.height-self.edgeInsets.bottom;
            if (CGRectContainsPoint(edgeFrame, _firstTouchLocation)) {
                _firstTouchArea |= YIEdgePanGestureRecognizerFirstTouchAreaBottom;
            }
            
            // top edge
            edgeFrame = self.view.bounds;
            edgeFrame.size.height = self.edgeInsets.top;
            if (CGRectContainsPoint(edgeFrame, _firstTouchLocation)) {
                _firstTouchArea |= YIEdgePanGestureRecognizerFirstTouchAreaTop;
            }
        }
        else {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)reset
{
    [super reset];
    
    _firstTouchLocation = CGPointZero;
    _firstTouchArea = YIEdgePanGestureRecognizerFirstTouchAreaNone;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    if (!CGPointEqualToPoint(_firstTouchLocation, CGPointZero)) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    if (!CGPointEqualToPoint(_firstTouchLocation, CGPointZero)) {
        
        //
        // Force-cancel other gestures (e.g. scrolling) for iOS6
        //
        // NOTE:
        // iOS5 calls canPreventGestureRecognizer when other gesture is active but not for iOS6,
        // so we implement cancelling logic on canBePreventedByGestureRecognizer here.
        //
        BOOL enabled = preventingGestureRecognizer.enabled;
        preventingGestureRecognizer.enabled = NO;
        preventingGestureRecognizer.enabled = enabled;
        
        return NO;
    }
    else {
        return YES;
    }
}

@end
