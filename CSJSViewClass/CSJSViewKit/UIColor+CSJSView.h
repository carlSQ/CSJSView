//
//  UIColor+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/17.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JSExport.h>

@protocol ColorJSExport<JSExport>

+ (UIColor *)jsColor:(NSString *)color;

+ (UIColor *)jsColor:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)blackColor;
+ (UIColor *)darkGrayColor;
+ (UIColor *)lightGrayColor;
+ (UIColor *)whiteColor;
+ (UIColor *)grayColor;
+ (UIColor *)redColor;
+ (UIColor *)greenColor;
+ (UIColor *)blueColor;
+ (UIColor *)cyanColor;
+ (UIColor *)yellowColor;
+ (UIColor *)magentaColor;
+ (UIColor *)orangeColor;
+ (UIColor *)purpleColor;
+ (UIColor *)brownColor;
+ (UIColor *)clearColor;

@property(nonatomic,readonly) CGColorRef CGColor;

@end

@interface UIColor (CSJSView)<ColorJSExport>

@end
