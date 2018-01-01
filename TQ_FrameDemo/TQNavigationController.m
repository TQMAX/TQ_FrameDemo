//
//  TQNavigationController.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2017/12/26.
//  Copyright © 2017年 TQ_Lemon. All rights reserved.
//

#import "TQNavigationController.h"

@interface TQNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgeGesOut;

@end

@implementation TQNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [bar setTitleTextAttributes:attrs];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //        button.size = CGSizeMake(30, 30);//没有加载其他库，暂时无法直接.size，故改用以下方法
        
        // 1. 用一个临时变量保存返回值。
        CGRect temp = self.view.frame;
        // 2. 给这个变量赋值。因为变量都是L-Value，可以被赋值
        temp.size.height = 30;
        temp.size.width = 30;
        // 3. 修改frame的值
        button.frame = temp;
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    return (self.topViewController !=[self.viewControllers firstObject]);
}
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    
    //解决与左滑手势冲突
    
    
    NSLog(@"%lu,%@",(unsigned long)self.childViewControllers.count,gestureRecognizer.view);
    
    //如果哪个控制器不需要策划返回，就可以返回NO
    //    if ([self.topViewController isKindOfClass:[CustomerServiceController class]]){
    //        return NO;
    //    }else if ([self.topViewController isKindOfClass:[ChatViewController class]]){
    //        return NO;
    //    }else if ([self.topViewController isKindOfClass:[WJLoginSelectViewController class]]){
    //        return NO;
    //    }
    
    
    return self.childViewControllers.count == 1 ? NO : YES;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    
    
    self.screenEdgeGesOut = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:target action:handler];
    self.screenEdgeGesOut.edges = UIRectEdgeLeft;
    self.screenEdgeGesOut.delegate = self;
    
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    [targetView addGestureRecognizer:self.screenEdgeGesOut];
    
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
    
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
