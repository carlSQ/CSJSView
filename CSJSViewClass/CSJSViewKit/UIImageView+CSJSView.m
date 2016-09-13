//
//  UIImageView+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UIImageView+CSJSView.h"
#import "CSJSViewEngine.h"

@implementation UIImageView (CSJSView)

+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
  return [self imageViewWithImage:image frame:frame highlightedImage:nil];
}
+ (instancetype)imageViewWithImage:(UIImage *)image frame:(CGRect)frame highlightedImage:(UIImage *)highlightedImage{
  UIImageView *imageView = [[UIImageView alloc] initWithImage:image highlightedImage:highlightedImage];
  imageView.frame = frame;
  return imageView;
}

@end
