//
//  UIColor+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/17.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UIColor+CSJSView.h"

@implementation UIColor (CSJSView)


+ (UIColor *)jsColor:(NSString *)color {
  return [self jsColor:color alpha:1.0];
}

+ (UIColor *)jsColor:(NSString *)color alpha:(CGFloat)alpha {
  NSString *cString = [[color
                        stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  if ([cString hasPrefix:@"#"])
  cString = [cString substringFromIndex:1];
  if ([cString length] != 6)
  return [UIColor blackColor];
  
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  unsigned int r, g, b;
  
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float)r / 255.0f)green:((float)g / 255.0f)blue:((float)b / 255.0f) alpha:(alpha <=1.0 ?:1.0)];
}

@end
