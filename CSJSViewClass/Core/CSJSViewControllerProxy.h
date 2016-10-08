//
//  CSJSViewControllerProxy.h
//  CSJSView
//
//  Created by 沈强 on 16/9/12.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "CSJSViewController.h"
#import <JavaScriptCore/JSExport.h>

@protocol CSJSViewControllerProxy <JSExport>

@property(nonatomic, weak)CSJSViewController *controller;

@end

@interface CSJSViewControllerProxy : NSObject<CSJSViewControllerProxy>

@property(nonatomic, weak)CSJSViewController *controller;

@property(nonatomic, strong) JSValue *jsManagedValue;

- (instancetype)initWithJSManagedValue:(JSValue *)jsManagedValue
                            controller:(CSJSViewController *)controller;
- (void)clear;

@end
