//
//  TQContentScrollView.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2017/12/27.
//  Copyright © 2017年 TQ_Lemon. All rights reserved.
//

#import "TQContentScrollView.h"

@implementation TQContentScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setOffset:(CGPoint)offset {
    _offset = offset;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (TQHeadViewHeight - self.offset.y);
    if (hitHead || !view) {
        self.scrollEnabled = NO;
        if (!view) {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x) {
                    view = subView;
                }
            }
        }
        return view;
    } else {
        self.scrollEnabled = YES;
        return view;
    }
}


@end
