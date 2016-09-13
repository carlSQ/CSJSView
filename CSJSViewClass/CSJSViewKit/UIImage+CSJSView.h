//
//  UIImage+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JSExport.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImageJSExport <JSExport>

+ (nullable UIImage *)jsImageNamed:(NSString *)name;

+ (nullable UIImage *)jsImageWithContentsOfFile:(NSString *)path;

@end

@interface UIImage (CSJSView)<ImageJSExport>

@end

NS_ASSUME_NONNULL_END
