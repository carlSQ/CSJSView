//
//  UIFont+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JSExport.h>

@protocol FontExport<JSExport>

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)italicSystemFontOfSize:(CGFloat)fontSize;

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight NS_AVAILABLE_IOS(8_2);
+ (UIFont *)monospacedDigitSystemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight NS_AVAILABLE_IOS(9_0);

@end

@interface UIFont (CSJSView)<FontExport>

@end
