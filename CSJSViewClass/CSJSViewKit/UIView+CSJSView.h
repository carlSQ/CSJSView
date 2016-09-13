//
//  UIView+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/17.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JSExport.h>
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

- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;
- (void)removeFromSuperview;
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2;

- (void)addSubview:(UIView *)view;
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview;

- (void)bringSubviewToFront:(UIView *)view;
- (void)sendSubviewToBack:(UIView *)view;


+ (UIView *)jsViewWithFrame:(CGRect)frame;

@end

@interface UIView (CSJSView)<ViewJSExport>



@end
NS_ASSUME_NONNULL_END
