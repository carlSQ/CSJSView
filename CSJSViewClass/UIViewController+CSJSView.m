//
//  UIViewController+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UIViewController+CSJSView.h"
#import <objc/runtime.h>
#import "CSJSViewEngine.h"

@implementation UIViewController (CSJSView)

#pragma mark - hook

+ (void)load {
  
  static dispatch_once_t token;
  
  dispatch_once(&token, ^{
    
    [self exchangeSel:@selector(viewDidLoad) newSel:@selector(CSJSView_viewDidLoad)];
    [self exchangeSel:@selector(viewWillAppear:) newSel:@selector(CSJSView_viewWillAppear:)];
    [self exchangeSel:@selector(viewDidAppear:) newSel:@selector(CSJSView_viewDidAppear:)];
    [self exchangeSel:@selector(viewWillDisappear:) newSel:@selector(CSJSView_viewWillDisappear:)];
    [self exchangeSel:@selector(viewDidDisappear:) newSel:@selector(CSJSView_viewDidDisappear:)];
    [self exchangeSel:@selector(didReceiveMemoryWarning) newSel:@selector(CSJSView_didReceiveMemoryWarning)];
    
  });
  
}


+ (void)exchangeSel:(SEL)orginSel
             newSel:(SEL)newSel {
  
  NSAssert(orginSel, @"orginMethod can not nil");
  
  NSAssert(newSel, @"newMethod can not nil");
  
  Method newMethod = class_getInstanceMethod([self class], newSel);
  
  Method orginMethod = class_getInstanceMethod([self class], orginSel);
  
  method_exchangeImplementations(orginMethod, newMethod);
  
}


#pragma mark - init


- (instancetype)initWithSourcePath:(NSString *)sourcePath
                            module:(NSString *)module
                        initParams:(NSDictionary *)params {
  
  if (self = [self init]) {
    
    JSValue *moduleValue = [CSJSViewEngine executeJSCall:@"ModulesRegistry" method:@"runApplication" arguments:@[module,sourcePath, params]];
    [moduleValue setObject:self forKeyedSubscript:@"self"];
    JSManagedValue *managedValue = [JSManagedValue managedValueWithValue:moduleValue];
    
    [[CSJSViewEngine virtualMachine] addManagedReference:managedValue withOwner:self];
    
    self.jsView = managedValue;
  }
  return self;
}

- (JSManagedValue *)jsView {
  return objc_getAssociatedObject(self, @selector(setJsView:));
}

- (void)setJsView:(JSManagedValue *)jsView {
  objc_setAssociatedObject(self, _cmd, jsView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)CSJSView_viewDidLoad {
  [self CSJSView_viewDidLoad];
  [self.jsView.value invokeMethod:@"viewDidLoad" withArguments:nil];

}

- (void)CSJSView_viewWillAppear:(BOOL)animated {
  [self CSJSView_viewWillAppear:animated];

  [self.jsView.value invokeMethod:@"viewWillAppear" withArguments:nil];
}

- (void)CSJSView_viewDidAppear:(BOOL)animated {
  [self CSJSView_viewDidAppear:animated];

  [self.jsView.value invokeMethod:@"viewDidAppear" withArguments:nil];
}

- (void)CSJSView_viewWillDisappear:(BOOL)animated {
  [self CSJSView_viewWillDisappear:animated];
  [self.jsView.value invokeMethod:@"viewWillDisappear" withArguments:nil];
}

- (void)CSJSView_viewDidDisappear:(BOOL)animated {
  [self CSJSView_viewDidDisappear:animated];
  [self.jsView.value invokeMethod:@"viewDidDisappear" withArguments:nil];
}

- (void)CSJSView_didReceiveMemoryWarning {
  
  [self CSJSView_didReceiveMemoryWarning];
  
  [self.jsView.value invokeMethod:@"didReceiveMemoryWarning" withArguments:nil];
}


@end
