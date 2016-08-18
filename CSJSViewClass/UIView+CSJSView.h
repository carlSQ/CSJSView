//
//  UIView+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/17.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ViewJSExport<JSExport>

@property(nonatomic) CGRect            frame;
@property(nonatomic) CGRect            bounds;
@property(nonatomic) CGPoint           center;
@property(nonatomic) CGAffineTransform transform;
@property(nullable, nonatomic,readonly) UIView       *superview;
@property(nonatomic,readonly,copy) NSArray<__kindof UIView *> *subviews;
@property(nullable, nonatomic,readonly) UIWindow     *window;
@property(nullable, nonatomic,copy)            UIColor          *backgroundColor;

@end

@interface UIView (CSJSView)<ViewJSExport>

@end
NS_ASSUME_NONNULL_END
