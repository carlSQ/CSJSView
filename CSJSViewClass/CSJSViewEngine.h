//
//  CSJSViewEngine.h
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSVirtualMachine.h>

@interface CSJSViewEngine : NSObject

+ (JSVirtualMachine *)virtualMachine;

+ (JSContext *)JSContext;

+ (void)startupCSJSViewEngineWithRootPath:(NSString *)jsRootPath;

+ (JSValue *)executeJSCall:(NSString *)module
                    method:(NSString *)method
                 arguments:(NSArray *)arguments;

@end
