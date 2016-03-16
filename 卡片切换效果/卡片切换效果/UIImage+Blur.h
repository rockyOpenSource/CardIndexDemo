//
//  UIImage+Blur.h
//  卡片切换效果
//
//  Created by skma on 16/3/2.
//  Copyright © 2016年 skma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

/**
 * 图片模糊方法
 **/

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
