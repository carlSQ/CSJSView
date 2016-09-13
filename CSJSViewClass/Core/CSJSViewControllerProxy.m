//
//  CSJSViewControllerProxy.m
//  CSJSView
//
//  Created by 沈强 on 16/9/12.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSViewControllerProxy.h"
#import "CSJSViewEngine.h"
#include <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSValueRef.h>
#import "CSJSValueMemory.h"

#define CSJS_NAME(value) [NSString stringWithFormat:@"CSJS_%@",@([value hash]).stringValue]

@implementation CSJSViewControllerProxy

- (instancetype)initWithJSManagedValue:(JSManagedValue *)jsManagedValue
                            controller:(CSJSViewController *)controller {
  if (self = [super init]) {
    self.controller = controller;
    self.jsManagedValue = jsManagedValue;
    
    JSValue *selfValue = [JSValue valueWithObject:self inContext:[CSJSViewEngine JSContext]];
    
     [jsManagedValue.value setObject:selfValue forKeyedSubscript:@"self"];
//    [[CSJSViewEngine JSContext] setObject:[JSValue valueWithObject:self inContext:[CSJSViewEngine JSContext]] forKeyedSubscript:CSJS_NAME(self)];
//    JSValueProtect([CSJSViewEngine JSContext].JSGlobalContextRef,self.jsManagedValue.value.JSValueRef);
    [[CSJSViewEngine virtualMachine] addManagedReference:self.jsManagedValue  withOwner:self];
    [CSJSValueMemory retain:self.jsManagedValue.value];
  }
  return self;
}

- (void)clear {
  [[CSJSViewEngine virtualMachine] removeManagedReference:self.jsManagedValue withOwner:self];
//  [self.jsManagedValue.value deleteProperty:@"self"];
//  [self.jsManagedValue.value deleteProperty:CSJS_NAME(self)];
//  [self.jsManagedValue.value setObject:[JSValue valueWithNullInContext:[CSJSViewEngine JSContext]] forKeyedSubscript:@"self"];
//  [[CSJSViewEngine JSContext] setObject:[JSValue valueWithNullInContext:[CSJSViewEngine JSContext]] forKeyedSubscript:CSJS_NAME(self)];
//  JSValueUnprotect([CSJSViewEngine JSContext].JSGlobalContextRef,self.jsManagedValue.value.JSValueRef);
//  JSValueUnprotect([CSJSViewEngine JSContext].JSGlobalContextRef,self.jsManagedValue.value.JSValueRef);
   [CSJSValueMemory release:self.jsManagedValue.value];
  self.jsManagedValue = nil;
}

- (void)dealloc {
  NSLog(@"CSJSViewControllerProxy release %@", self);
}

@end
