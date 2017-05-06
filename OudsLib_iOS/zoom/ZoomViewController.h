//
//  ZoomViewController.h
//  Touches
//
//  Created by Zhongyu Zhang on 11-12-21.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController <UIGestureRecognizerDelegate>
{
//    需要以后进行重构
//    UIView *zoomView;
//    UIImageView *imgView;
    
	int touchCount;
    UIView *imgForReset;
	CGPoint startTouchPosition; 
}

- (void)addGestureRecognizersToPiece:(UIView *)piece;

@end
