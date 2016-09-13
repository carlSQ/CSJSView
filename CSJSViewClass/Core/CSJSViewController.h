//
//  UIViewController+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ViewControllerJSExport <JSExport>

@property(nonatomic, strong) UIView *view;

@property(nullable, nonatomic,copy) NSString *title;
@property(nullable, nonatomic,weak,readonly) UIViewController *parentViewController;
@property(nullable, nonatomic,readonly) UIViewController *modalViewController;
@property(nullable, nonatomic,readonly) UIViewController *presentedViewController;
@property(nullable, nonatomic,readonly) UIViewController *presentingViewController;
@property(nullable, nonatomic,readonly,strong) UINavigationController *navigationController; 

+ (instancetype)sourcePath:(NSString *)sourcePath
                    module:(NSString *)module
                initParams:(NSDictionary *)params;
@end

@class CSJSViewControllerProxy;
@interface CSJSViewController : UIViewController  <ViewControllerJSExport>

@property(nonatomic, strong) CSJSViewControllerProxy *controllerProxy;

+ (instancetype)sourcePath:(NSString *)sourcePath
module:(NSString *)module
initParams:(NSDictionary *)params;

@end
NS_ASSUME_NONNULL_END
