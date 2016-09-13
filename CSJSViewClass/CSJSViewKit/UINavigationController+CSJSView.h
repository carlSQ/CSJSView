//
//  UINavigationController+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/24.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NavigationControllerJSExport <JSExport>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
@end

@interface UINavigationController (CSJSView)<NavigationControllerJSExport>



@end
