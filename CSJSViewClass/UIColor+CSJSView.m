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
  NSString *cString = [[color
                        stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
  // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
  if ([cString hasPrefix:@"#"])
  cString = [cString substringFromIndex:1];
  if ([cString length] != 6)
  return [UIColor blackColor];
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  // Scan values
  unsigned int r, g, b;
  
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float)r / 255.0f)green:((float)g / 255.0f)blue:((float)b / 255.0f)alpha:1.0f];
}

@end
