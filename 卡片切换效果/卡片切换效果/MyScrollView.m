//
//  MyScrollView.m
//  Test
//
//  Created by skma on 16/3/5.
//  Copyright © 2016年 skma. All rights reserved.
//

#import "MyScrollView.h"
#import "UIImageView+WebCache.h"
#import "SecondViewController.h"

#define sWIDTH  [UIScreen mainScreen].bounds.size.width
#define sHEIGHT   [UIScreen mainScreen].bounds.size.height


@interface MyScrollview () <UIScrollViewDelegate>

//@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation MyScrollview

{
    UIScrollView *scrollview;
}

- (NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        self.imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (id)initWithFrame:(CGRect)frame target:(id<UIScrollViewDelegate>)target{
    self = [super initWithFrame:frame];
    if (self){
        scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(sWIDTH / 6, 0, sWIDTH * 2 / 3, sHEIGHT)];
        scrollview.pagingEnabled = YES;
        scrollview.clipsToBounds = NO;
        [self addSubview:scrollview];
        self.clipsToBounds = YES;
        // 添加代理
        scrollview.delegate = target;
    }
    return self;
}

// 加载本地图片
- (void)loadImages:(NSArray *)array{
    _picArray = array;
    int index = 0;
    [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(NSString * name in array){
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        
        iv.contentMode = UIViewContentModeScaleToFill;
        
        iv.frame = CGRectMake(sWIDTH * 2 / 3 * index, sHEIGHT / 6, sWIDTH * 2 / 3, sHEIGHT * 2 / 3);
        
        [scrollview addSubview:iv];
     
        index++;
    }
    
    scrollview.contentSize = CGSizeMake((scrollview.frame.size.width) * index, 0);
}


// 加载网络图片
- (void)loadImagesWithUrl:(NSArray *)array{
    _picArray = array;
    int index = 0;
    [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for(NSString * name in array){
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(sWIDTH * 2 / 3 * index, sHEIGHT / 6, sWIDTH * 2 / 3, sHEIGHT * 2 / 3)];
        if (index != 0) {
            CGRect image = iv.bounds;
            image.size.width =  sWIDTH * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * 1) )/ sWIDTH * 2 / 3 + 0.8 *sWIDTH * 2 / 3;
            image.size.height =  sHEIGHT * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * 1) )/ sWIDTH * 2 / 3 + 0.8 *sHEIGHT * 2 / 3;
            iv.bounds = image;
        }
        
        [iv sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"0"]];
        iv.contentMode = UIViewContentModeScaleToFill;
        [scrollview addSubview:iv];
        [self.imageViewArray addObject:iv];
        iv.tag = index;
        
        index++;
    }
    scrollview.contentSize = CGSizeMake((scrollview.frame.size.width) * index, 0);
}

// 滚动时改变大小
#pragma <#arguments#>
- (void)scroll{
    int index = scrollview.contentOffset.x / (sWIDTH * 2 / 3);
    if (index == 0) {
        for (int i = 0; i < 2; i++) {
            UIImageView *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  sWIDTH * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sWIDTH * 2 / 3;
            image.size.height =  sHEIGHT * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sHEIGHT * 2 / 3;
            im.bounds = image;
        }
    }else if(index == _picArray.count - 1){
        for (int i = index - 1; i < index + 1; i++) {
            UIImageView *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  sWIDTH * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sWIDTH * 2 / 3;
            image.size.height =  sHEIGHT * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sHEIGHT * 2 / 3;
            im.bounds = image;
        }
    }else{
        for (int i = index - 1; i < index + 2; i++) {
            UIImageView *im = _imageViewArray[i];
            CGRect image = im.bounds;
            image.size.width =  sWIDTH * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sWIDTH * 2 / 3;
            image.size.height =  sHEIGHT * 2 / 3 * 0.2 * (sWIDTH * 2 / 3 -  fabs(scrollview.contentOffset.x - sWIDTH * 2 / 3 * i) )/ (sWIDTH * 2 / 3) + 0.8 * sHEIGHT * 2 / 3;
            im.bounds = image;
        }
    }
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *view = [super hitTest:point withEvent:event];
//    if ([view isEqual:self])  {
//        for(UIView *subview in scrollview.subviews) {
//            CGPoint offset = CGPointMake(point.x - scrollview.frame.origin.x + scrollview.contentOffset.x - subview.frame.origin.x, point.y - scrollview.frame.origin.y + scrollview.contentOffset.y - subview.frame.origin.y);
//            if ((view = [subview hitTest:offset withEvent:event])){
//                return view;
//            }
//        }
//        return scrollview;
//    }
//    return view;
//}



@end

