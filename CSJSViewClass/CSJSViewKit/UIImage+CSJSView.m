//
//  UIImage+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UIImage+CSJSView.h"
#import "CSJSViewEngine.h"

@implementation UIImage (CSJSView)

+ (UIImage *)jsImageNamed:(NSString *)name {
  return [UIImage imageNamed:name];
}

+ (UIImage *)jsImageWithContentsOfFile:(NSString *)path {
  return [UIImage imageWithContentsOfFile:path];
}
@end
