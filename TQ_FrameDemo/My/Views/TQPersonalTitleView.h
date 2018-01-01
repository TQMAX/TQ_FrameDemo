//
//  TQPersonalTitleView.h
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2018/1/1.
//  Copyright © 2018年 TQ_Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQPersonalTitleView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^buttonSelected)(NSInteger index);

@end
