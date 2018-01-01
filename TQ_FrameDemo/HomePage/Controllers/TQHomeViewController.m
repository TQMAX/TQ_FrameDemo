//
//  TQHomeViewController.m
//  TQ_FrameDemo
//
//  Created by TQ_Lemon on 2017/12/26.
//  Copyright © 2017年 TQ_Lemon. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define TopViewH 35
#define btnWidth ScreenW/2
//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "TQHomeViewController.h"
#import "TQContentScrollView.h"
#import "TQLeftTableViewController.h"
#import "TQRightTableViewController.h"

@interface TQHomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIButton *left;
@property (nonatomic,strong)UIButton *right;
@property (nonatomic,strong)UIButton *seletedBtn;
@property (nonatomic,strong)UIView *backView;

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)TQLeftTableViewController *leftTableView;
@property (nonatomic,strong)TQRightTableViewController *rightTableView;

@end

@implementation TQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabelView];
    [self createHeadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabelView{
    
    TQContentScrollView *scrollView = [[TQContentScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 64)];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    
    self.leftTableView = [[TQLeftTableViewController alloc]init];
    self.leftTableView.view.frame = CGRectMake(0, TopViewH, ScreenW, ScreenH - 64 - TopViewH - 48);
    [scrollView addSubview:self.leftTableView.view];
    
    self.rightTableView = [[TQRightTableViewController alloc]init];
    self.rightTableView.view.frame = CGRectMake(ScreenW, TopViewH, ScreenW, ScreenH - 64 - TopViewH -48);
    [scrollView addSubview:self.rightTableView.view];
}

//头部的按钮
- (void)createHeadUI{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, TopViewH)];
    view.backgroundColor = UIColorFromRGB(0xf6f4f7);
    [self.view addSubview:view];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, btnWidth, TopViewH)];
    self.backView.backgroundColor = UIColorFromRGB(0xff386b);
    self.backView.layer.cornerRadius = 0;
    [view addSubview:self.backView];
    
    self.left = [UIButton buttonWithType:UIButtonTypeCustom];
    self.left.frame = CGRectMake(0, 0, btnWidth, TopViewH);
    [self.left setTitle:@"我是左边的列表" forState:UIControlStateNormal];
    self.left.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.left setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.left setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [self.left addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.left];
    self.left.tag = 0;
    //设置为选中状态
    self.left.selected = YES;
    self.seletedBtn = self.left;
    
    //按钮
    self.right = [UIButton buttonWithType:UIButtonTypeCustom];
    self.right.frame = CGRectMake(btnWidth, 0, btnWidth, TopViewH);
    [self.right setTitle:@"我是右边的列表" forState:UIControlStateNormal];
    self.right.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.right setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [self.right setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    [self.right addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.right];
    self.right.tag = 1;
    
    UIView *wLine = [[UIView alloc]initWithFrame:CGRectMake(0, TopViewH - 1, ScreenW, 1)];
    wLine.backgroundColor = UIColorFromRGB(0xe8e8e8);
    [self.view addSubview:wLine];
    
}

- (void)buttonclick:(UIButton *)button{
    if (button != self.seletedBtn){
        button.selected = YES;
        self.seletedBtn.selected = NO;
        self.seletedBtn = button;
    }else{
        self.seletedBtn.selected = YES;
    }
    CGFloat tag = button.tag;
    if (button.tag == 0){
        self.left.selected = YES;
        self.right.selected = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.backView.frame = CGRectMake(0, 0, btnWidth, TopViewH);
            self.scrollView.contentOffset = CGPointMake(ScreenW * tag, - 64);
        }];
    }else{
        self.left.selected = NO;
        self.right.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.backView.frame = CGRectMake(ScreenW/2 , 0, btnWidth, TopViewH);
            self.scrollView.contentOffset = CGPointMake(ScreenW * tag, - 64);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//滑动Scrollview后，做动画变化
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        NSInteger pageNum = contentOffsetX / ScreenW + 0.5;
        if (pageNum == 0){
            [UIView animateWithDuration:0.25 animations:^{
                self.backView.frame = CGRectMake(0, 0, btnWidth, TopViewH);
                self.left.selected = YES;
                self.right.selected = NO;
                self.seletedBtn = self.left;
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.backView.frame = CGRectMake(ScreenW/2 , 0, btnWidth, TopViewH);
                self.left.selected = NO;
                self.right.selected = YES;
                self.seletedBtn = self.right;
            }];
        }
    }
}


@end
