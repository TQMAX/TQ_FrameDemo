//
//  TQFrameDemoTabBar.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2017/12/26.
//  Copyright © 2017年 TQ_Lemon. All rights reserved.
//

#import "TQFrameDemoTabBar.h"
#import "TQNavigationController.h"
#import "TQHomeViewController.h"
#import "AVPViewController.h"
#import "TQMessageViewController.h"
#import "TQMyCenterViewController.h"

@interface TQFrameDemoTabBar ()
@property (nonatomic, weak) UIButton *composeButton;

@end

@implementation TQFrameDemoTabBar

#pragma mark - 统一设置所有 UITabBarItem 的文字属性
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255/255.0 green:125/255.0 blue:0 alpha:1];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self addChildViewControllers];
        [self addComposeButton];
    }
    return self;
}

#pragma mark - 添加所有子控制器
- (void)addChildViewControllers {
    [self addChildVc:[[TQHomeViewController alloc]init] title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home"];
    [self addChildVc:[[AVPViewController alloc]init] title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover"];
    [self addChildViewController: [[UIViewController alloc] init]];
    [self addChildVc:[[TQMessageViewController alloc]init] title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center"];
    [self addChildVc:[[TQMyCenterViewController alloc]init] title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile"];
}

#pragma mark-添加子控制器
- (void)addChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selecImage
{
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 /255.0 green:arc4random() % 256 /255.0 blue:arc4random() % 256 /255.0 alpha:1.0];  // 设置背景为随机色
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
//    vc.tabBarItem.selectedImage =[UIImage imageNamed:selecImage];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", selecImage]];
    TQNavigationController *nav = [[TQNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

#pragma mark - 添加中间的按钮
- (void)addComposeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon_highlighted"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.composeButton = button;
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    CGFloat width = self.tabBar.bounds.size.width / self.childViewControllers.count - 2;
    self.tabBar.tintColor = [UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1];
    button.frame = CGRectInset(self.tabBar.bounds, 2 * width, 0);
}

#pragma mark - 点击写加号按钮
- (void)composeButtonClick:(UIButton *)button {
    NSLog(@"\n点击了写加号按钮");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.composeButton];
}

@end
