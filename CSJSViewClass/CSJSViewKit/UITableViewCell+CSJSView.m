//
//  UITableViewCell+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UITableViewCell+CSJSView.h"
#import "CSJSViewEngine.h"

@implementation UITableViewCell (CSJSView)
  
+ (instancetype)jsTableViewCellWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
  return  [[self alloc]initWithStyle:style reuseIdentifier:reuseIdentifier];
}
  
@end
