//
//  CSJSValueMemory.h
//  CSJSView
//
//  Created by 沈强 on 16/9/11.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JSValue.h>

@interface CSJSValueMemory : NSObject


+ (void)retain:(JSValue *)jsValue;

+ (void)release:(JSValue *)jsValue;

@end
