//
//  CSJSBridge.m
//  CSJSView
//
//  Created by 沈强 on 16/10/1.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSBridge.h"

@implementation CSJSBridge

+ (void)callClassMethod:(NSString *)className method:(NSString *)methodName args:(NSArray *)args {
  
  Class targetClass = NSClassFromString(className);
  
  NSAssert(targetClass, @"class %@ not found", className);
  
  NSMethodSignature *methodSignature = [targetClass methodSignatureForSelector:NSSelectorFromString(methodName)];
  
  NSAssert(methodSignature, @"unrecognized method %@ for class %@", methodName, className);

  NSInvocation *invocation= [NSInvocation invocationWithMethodSignature:methodSignature];
  
  [invocation setTarget:targetClass];
  
  [invocation setSelector:NSSelectorFromString(methodName)];
  
  NSUInteger numberOfMethodArguments = methodSignature.numberOfArguments;
  
  NSAssert(numberOfMethodArguments == args.count + 2, @"method %@ of class %@ input args count not equal",methodName, className);
  
  [invocation invoke];
  
}

@end
