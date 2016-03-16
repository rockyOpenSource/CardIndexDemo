//
//  SecondViewController.m
//  卡片切换效果
//
//  Created by skma on 16/3/2.
//  Copyright © 2016年 skma. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImageView+WebCache.h"
#define sWIDTH [[UIScreen mainScreen] bounds].size.width
#define sHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface SecondViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SecondViewController

// 数组懒加载
- (NSArray *)picArray{
    if (!_picArray) {
        self.picArray = [NSArray array];
    }
    return _picArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(sWIDTH * _picArray.count, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _picArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(sWIDTH * i, 0, sWIDTH, sHEIGHT)];
        [_scrollView addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://box.dwstatic.com/skin/Irelia/Irelia_%d.jpg", i]] placeholderImage:[UIImage imageNamed:@"back"]];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"自由之翼.jpg"];
    _scrollView.contentOffset = CGPointMake(sWIDTH * _x, 0);
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(10, 20, 40, 20);
    [back setTitle:@"<<<" forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, sHEIGHT - 40, sWIDTH, 30)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = _picArray.count;
    _pageControl.currentPage = _x;
    
    
}

- (void)back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = _scrollView.contentOffset.x / sWIDTH;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
