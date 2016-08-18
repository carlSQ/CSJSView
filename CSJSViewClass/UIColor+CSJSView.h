//
//  UIColor+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/17.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ColorJSExport<JSExport>

+ (UIColor *)jsColor:(NSString *)color;

@end

@interface UIColor (CSJSView)<ColorJSExport>

@end
