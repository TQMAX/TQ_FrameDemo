//
//  TQPersonalTitleView.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2018/1/1.
//  Copyright © 2018年 TQ_Lemon. All rights reserved.
//

#import "TQPersonalTitleView.h"

@interface TQPersonalTitleView()

@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation TQPersonalTitleView

- (void)titleButtonClicked:(UIButton *)button {
    _selectedIndex = button.tag;
    if (self.selectedButton) {
        self.selectedButton.selected = YES;
    }
    button.selected = NO;
    self.selectedButton = button;
    
    if (self.buttonSelected) {
        self.buttonSelected(button.tag);
    }
    
    NSString* title = self.titles[button.tag];
    CGFloat sliderWidth = button.titleLabel.font.pointSize * title.length;
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.frame = CGRectMake(button.center.x - sliderWidth/2, button.frame.size.height - 2, sliderWidth, 2);
        [self layoutIfNeeded];
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex   = selectedIndex;
    UIButton* button = self.subviews[selectedIndex];
    [self titleButtonClicked:button];
}

- (void)setTitles:(NSArray *)titles {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titles               = titles;
    CGFloat width         = [UIScreen mainScreen].bounds.size.width / titles.count;
    
    for ( int i           = 0; i<titles.count; i++ ) {
        UIButton* titleButton = [self titleButton:titles[i]];
        titleButton.tag       = i;
        [self addSubview:titleButton];
        titleButton.frame = CGRectMake(width * i, 0, width, 40);

        if (i != 0) {
            titleButton.selected  = YES;
        } else {
            self.selectedButton   = titleButton;
        }
    }
    UIButton *button      = self.subviews[0];
    NSString *title       = titles[0];
    CGFloat sliderWidth   = button.titleLabel.font.pointSize * title.length;
    [self addSubview:self.sliderView];
    self.sliderView.frame = CGRectMake(button.center.x - sliderWidth/2, button.frame.size.height - 2, sliderWidth, 2);
    [self layoutIfNeeded];
}

- (UIButton *)titleButton:(NSString *)title {
    UIButton* titleButton       = [[UIButton alloc] init];
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [titleButton setTitle:title forState:UIControlStateNormal];
    return titleButton;
}

- (void)drawRect:(CGRect)rect {
//    [self makelineStartPoint:self.sliderView.bottom andEndPoint:self.sliderView.bottom];
//    [self makelineStartPoint:self.selectedButton.top andEndPoint:self.selectedButton.top];
    [self makelineStartPoint:45 andEndPoint:45];
    [self makelineStartPoint:0 andEndPoint:0];
}

- (void)makelineStartPoint:(CGFloat)statPoint andEndPoint:(CGFloat)endPoint {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 0.5);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, statPoint);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, endPoint);   //终点坐标
    CGContextStrokePath(context);
}

- (UIView *)sliderView {
    if (!_sliderView) {
        UIView* sliderView            = [[UIView alloc] init];
        sliderView.backgroundColor    = [UIColor redColor];
        sliderView.layer.cornerRadius = 2;
        sliderView.clipsToBounds      = YES;
        _sliderView                   = sliderView;
    }
    return _sliderView;
}

@end
