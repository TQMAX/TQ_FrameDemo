//
//  TQPersonalMainViewController.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2018/1/1.
//  Copyright © 2018年 TQ_Lemon. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define TopViewH 35
#define btnWidth ScreenW/2

#import "TQPersonalMainViewController.h"
#import "TQPersonalTitleView.h"
#import "TQContentScrollView.h"
#import "TQLeftTableViewController.h"
#import "TQRightTableViewController.h"

@interface TQPersonalMainViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)TQLeftTableViewController *leftTableView;
@property (nonatomic,strong)TQRightTableViewController *rightTableView;

@property (nonatomic,strong)TQPersonalTitleView *titleView;

@end

@implementation TQPersonalMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    [self setTabelView];
    [self setupHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabelView{
    
    TQContentScrollView *scrollView = [[TQContentScrollView alloc] initWithFrame:CGRectMake(0, 45, ScreenW, ScreenH - 64)];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    
    self.leftTableView = [[TQLeftTableViewController alloc]init];
    self.leftTableView.view.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64 - TopViewH - 10);
    [scrollView addSubview:self.leftTableView.view];
    
    self.rightTableView = [[TQRightTableViewController alloc]init];
    self.rightTableView.view.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH - 64 - TopViewH - 10);
    [scrollView addSubview:self.rightTableView.view];

}

// tableView 的头部视图
- (void)setupHeaderView {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenW , 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    TQPersonalTitleView *titleView = [[TQPersonalTitleView alloc] init];
    [headerView addSubview:titleView];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.frame = CGRectMake(0, 0, ScreenW, 45);
    __weak typeof(self) weakSelf = self;
    titleView.titles = @[@"左边的列表", @"右边的列表"];
    titleView.selectedIndex = 0;
    titleView.buttonSelected = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenW * index, - 64) animated:YES];
    };
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffsetX / ScreenW + 0.5;
        [UIView animateWithDuration:0.25 animations:^{
            self.titleView.selectedIndex = pageNum;
        }];
    }
}

- (void)dealloc {
    NSLog(@"控制器已销毁");
}

@end
