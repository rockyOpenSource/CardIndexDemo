//
//  FirstViewController.m
//  卡片切换效果
//
//  Created by skma on 16/3/2.
//  Copyright © 2016年 skma. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UIImage+Blur.h"
#import "MyScrollView.h"
#import "UIImageView+WebCache.h"



#define sWIDTH [[UIScreen mainScreen] bounds].size.width
#define sHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface FirstViewController ()<UIScrollViewDelegate>

/**
 * 给Scrollview添加点击手势
 **/
@property (nonatomic, strong) UITapGestureRecognizer *tap;

/**
 * 定义属性
 **/
@property (nonatomic, strong) MyScrollview *scrollView;

/**
 * 模糊图片
 **/
@property (nonatomic, strong) UIImageView *imageView;

/**
 * 辅助图片
 **/
@property (nonatomic, strong) UIImageView *auxiliaryImageView;

/**
 * 图片网址数组
 **/
@property (nonatomic, strong) NSArray *urlArray;

/**
 * 用来接收是第几张图
 **/
@property (nonatomic) int x;

/**
 * 定义pageControl
 **/
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建imageView
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    self.navigationController.navigationBar.hidden = YES;

//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
//    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    
    // 创建自定义的scrollV
    self.scrollView = [[MyScrollview alloc]initWithFrame:self.view.bounds target:self];
    [self.view addSubview:_scrollView];

    // 创建辅助imageView
    self.auxiliaryImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    self.urlArray = @[@"http://box.dwstatic.com/skin/Irelia/Irelia_0.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_1.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_2.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_3.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_4.jpg", @"http://box.dwstatic.com/skin/Irelia/Irelia_5.jpg"];
    
    [_scrollView loadImagesWithUrl:_urlArray];
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [_scrollView addGestureRecognizer:_tap];

    
    [_auxiliaryImageView sd_setImageWithURL:[NSURL URLWithString:_urlArray[0]] placeholderImage:[UIImage imageNamed:@"back"]];
    [self performSelector:@selector(blur) withObject:nil afterDelay:0.2];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, sHEIGHT - 40, sWIDTH, 30)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = _urlArray.count;
    _pageControl.currentPage = 0;
}

// scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self blurImageView:scrollView];
}


// scrollView 的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
     [_scrollView scroll];
}


//
- (void)blurImageView:(UIScrollView *)scrollView{
    // 获取当前偏移量
    _x = scrollView.contentOffset.x / (sWIDTH * 2 / 3);
    _pageControl.currentPage = _x;
    
    [_auxiliaryImageView sd_setImageWithURL:[NSURL URLWithString:_urlArray[_x]] placeholderImage:[UIImage imageNamed:@"back"]];
    if (_x == 0) {
        [self performSelector:@selector(blur) withObject:nil afterDelay:0.2];
    }else{
        [self blur];
   
    }
    
}

// 模糊图片
- (void)blur{
    if (_auxiliaryImageView.image) {
        _imageView.image = [UIImage boxblurImage:_auxiliaryImageView.image withBlurNumber:0.5];
    }else{
        _imageView.image = [UIImage boxblurImage:[UIImage imageNamed:@"back"] withBlurNumber:0.5];
    }

}


// 点击事件
- (void)tap:(UITapGestureRecognizer *)tap{
    SecondViewController *SEVC = [[SecondViewController alloc]init];
    SEVC.x = _x;
    SEVC.picArray = _urlArray;
    [self.navigationController pushViewController:SEVC animated:YES];
}

// 执行模糊 毛玻璃
//- (void)blur:(UIButton *)button{
//    
//    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    
//    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
//    
//    view.frame = self.view.bounds;
//    view.alpha = 1;
//    
//    [self.view addSubview:view];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
