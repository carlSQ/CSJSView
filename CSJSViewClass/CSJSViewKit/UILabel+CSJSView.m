//
//  UILabel+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UILabel+CSJSView.h"
#import "CSJSViewEngine.h"

@implementation UILabel (CSJSView)

+ (instancetype)labelWithText:(NSString *)text frame:(CGRect)frame {
  UILabel *label = [[UILabel alloc]initWithFrame:frame];
  label.text = text;
  return label;
}
@end
