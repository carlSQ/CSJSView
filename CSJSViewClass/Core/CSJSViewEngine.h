//
//  CSJSViewEngine.h
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSVirtualMachine.h>
#import <JavaScriptCore/JSContextRef.h>

@interface CSJSViewEngine : NSObject

+ (void)startupCSJSViewEngineWithRootPath:(NSString *)jsRootPath;

+ (void)registerClass:(NSString *)className class:(Class)class;

+ (JSVirtualMachine *)virtualMachine;

+ (JSContext *)JSContext;

+ (JSValue *)executeJSCall:(NSString *)module
                    method:(NSString *)method
                 arguments:(NSArray *)arguments;

@end
