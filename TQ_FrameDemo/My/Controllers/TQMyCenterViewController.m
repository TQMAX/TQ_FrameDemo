//
//  TQMyCenterViewController.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2018/1/1.
//  Copyright © 2018年 TQ_Lemon. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#import "TQMyCenterViewController.h"
#import "TQPersonalMainViewController.h"
#import "TQSettingViewController.h"

@interface TQMyCenterViewController ()

@end

@implementation TQMyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/// 设置导航栏右边的按钮
- (void)setupNav {
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClick)];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)settingBtnClick {
    TQSettingViewController *vc = [[TQSettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake((ScreenW - 100) / 2, 200, 100, 40);
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClicked {
    TQPersonalMainViewController *vc = [[TQPersonalMainViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
