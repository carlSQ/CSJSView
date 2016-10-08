//
//  CSJSViewEngine.m
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSViewEngine.h"
#import <UIKit/UIKit.h>
#import "CSJSTableView.h"
#import "CSJSViewController.h"
#import "CSJSViewControllerProxy.h"


@interface CSJSViewEngine ()

@property(nonatomic, strong) JSVirtualMachine *virtualMachine;

@property(nonatomic, strong) JSContext *jsContext;

@property(nonatomic, strong) NSString *jsRootPath;

@property (nonatomic) JSContextGroupRef contextGroup;

@end

@implementation CSJSViewEngine

+ (instancetype)sharedCSJSViewEngine {
  
  static CSJSViewEngine *_sharedCSJSViewEngine = nil;
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _sharedCSJSViewEngine = [CSJSViewEngine new];
  });
  
  return _sharedCSJSViewEngine;
  
}

- (instancetype)init {
  if (self = [super init]) {
 
    _contextGroup = JSContextGroupCreate();
    JSGlobalContextRef globalContext = JSGlobalContextCreateInGroup(_contextGroup, NULL);
    _jsContext = [JSContext contextWithJSGlobalContextRef:globalContext];
   
    _virtualMachine = _jsContext.virtualMachine;
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
      NSLog(@"exception %@",exception.debugDescription);
    };
  }
  return self;
}

+ (void)registerClass:(NSString *)className class:(Class)class {
  CSJSViewEngine *engine = [CSJSViewEngine sharedCSJSViewEngine];
  engine.jsContext[className] = class;
}


+ (JSVirtualMachine *)virtualMachine {
  return [CSJSViewEngine sharedCSJSViewEngine].virtualMachine;
}

+ (JSContext *)JSContext {
  return [CSJSViewEngine sharedCSJSViewEngine].jsContext;
}

+ (JSContextGroupRef)contextGroup {
  return [CSJSViewEngine sharedCSJSViewEngine].contextGroup;
}

+ (void)startupCSJSViewEngineWithRootPath:(NSString *)jsRootPath {
  
  CSJSViewEngine *engine = [CSJSViewEngine sharedCSJSViewEngine];
  
  NSURL *engineUrl = [[NSBundle mainBundle] URLForResource:@"CSJSViewEngine" withExtension:@"js"];
  NSError *engineError = nil;
  NSString *engineScript = [NSString stringWithContentsOfURL:engineUrl encoding:NSUTF8StringEncoding error:&engineError];
  [engine.jsContext evaluateScript:engineScript withSourceURL:engineUrl];
  
  engine.jsRootPath = jsRootPath;
  
  [self addJavascript];
}

+ (void)addJavascript {
  
  CSJSViewEngine *engine = [CSJSViewEngine sharedCSJSViewEngine];
  
  engine.jsContext[@"nativeLoadJSModule"] = ^(JSValue*global,JSValue*require, JSValue *module, JSValue*exports, JSValue *path){
    
    NSString *jsModulePath = [path toString];
    NSString *fullPath = nil;
    
    if ([jsModulePath hasPrefix:@"./"]||[jsModulePath hasPrefix:@"../"]) {
      fullPath = [engine.jsRootPath stringByAppendingPathComponent:[jsModulePath hasPrefix:@"./"] ? [jsModulePath stringByReplacingOccurrencesOfString:@"./" withString:@""] : [jsModulePath stringByReplacingOccurrencesOfString:@"../" withString:@""]];
    } else {
      fullPath = [[NSBundle mainBundle] pathForResource:[jsModulePath stringByReplacingOccurrencesOfString:@".js" withString:@""] ofType:@"js"];
    }
    
    if (!fullPath) {
      [[JSContext currentContext] setException:[JSValue valueWithNewErrorFromMessage:[NSString stringWithFormat:@"path: %@ format wrong", jsModulePath] inContext:[JSContext currentContext]]];
      return;
    }
    
    NSError *loadError = nil;
    NSString *jsSource = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&loadError];
    
    if (loadError) {
      [[JSContext currentContext] setException:[JSValue valueWithNewErrorFromMessage:[NSString stringWithFormat:@"path not find: %@", jsModulePath] inContext:[JSContext currentContext]]];
      return;
    }
    NSString *loadModule = [NSString stringWithFormat:@"(function() { return function(global, require, module, exports){%@};})();",jsSource];
   JSValue *loadFunction = [[JSContext currentContext] evaluateScript:loadModule withSourceURL:[NSURL URLWithString:fullPath]];
    [loadFunction callWithArguments:@[global,require,module,exports,path]];
  };
  
  engine.jsContext[@"Native_log"] = ^() {
    
#ifdef DEBUG
    
    NSArray *args = [JSContext currentArguments];
    
    for (JSValue *value in args) {
       NSLog(@"CSJSView: %@",[value toString].debugDescription);
    }
   
    
#endif
    
  };
  
  engine.jsContext[@"Native_Assert"] = ^(JSValue *booValue, JSValue *desValue) {
    NSAssert(booValue.toBool, desValue.toString);
  };
  
  engine.jsContext[@"JSView"] = [UIView class];
  engine.jsContext[@"JSColor"] = [UIColor class];
  [CSJSViewEngine registerClass:@"JSTableView" class:[CSJSTableView class]];
  [CSJSViewEngine registerClass:@"JSButton" class:[UIButton class]];
  [CSJSViewEngine registerClass:@"JSLabel" class:[UILabel class]];
  [CSJSViewEngine registerClass:@"JSFont" class:[UIFont class]];
  [CSJSViewEngine registerClass:@"JSTableViewCell" class:[UITableViewCell class]];
  [CSJSViewEngine registerClass:@"JSImage" class:[UIImage class]];
  [CSJSViewEngine registerClass:@"JSImageView" class:[UIImageView class]];
  [CSJSViewEngine registerClass:@"JSViewController" class:[CSJSViewController class]];
  [CSJSViewEngine registerClass:@"JSNavigationViewController" class:[UINavigationController class]];
  [CSJSViewEngine registerClass:@"CSJSViewControllerProxy" class:[CSJSViewControllerProxy class]];
}

+ (JSValue *)jsValueWith:(NSString *)jsAddress {
  return [self executeJSCall:@"ObjectMemory" method:@"getObject" arguments:@[jsAddress]];
}

+ (void)releaseJSValueWith:(NSString *)jsAddress {
  [self executeJSCall:@"ObjectMemory" method:@"releaseObject" arguments:@[jsAddress]];
}


+ (JSValue *)executeJSCall:(NSString *)module
                    method:(NSString *)method
                 arguments:(NSArray *)arguments {
  
  JSValue *globalValue = [CSJSViewEngine JSContext].globalObject;
  
  JSValue *moduleValue = nil;
  
  if (module) {
     moduleValue = [globalValue objectForKeyedSubscript:module];
  }
  
  if (!method) {
#ifdef DEBUG
    [NSException raise:@"method  nil" format:@"module %@: pass method is null", module];
#endif
  }
  
  JSValue *resultValue = [moduleValue?:globalValue invokeMethod:method withArguments:arguments];
  
  return resultValue;

}


@end

