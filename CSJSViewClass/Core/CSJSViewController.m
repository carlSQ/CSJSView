//
//  UIViewController+CSJSView.m
//  CSJSView
//
//  Created by 沈强 on 16/8/16.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSViewController.h"
#import <objc/runtime.h>
#import "CSJSViewEngine.h"
#import "CSJSViewControllerProxy.h"

@implementation CSJSViewController

#pragma mark - hook

+ (void)load {
  
//  static dispatch_once_t token;
//  
//  dispatch_once(&token, ^{
//    
//    [self exchangeSel:@selector(viewDidLoad) newSel:@selector(CSJSView_viewDidLoad)];
//    [self exchangeSel:@selector(viewWillAppear:) newSel:@selector(CSJSView_viewWillAppear:)];
//    [self exchangeSel:@selector(viewDidAppear:) newSel:@selector(CSJSView_viewDidAppear:)];
//    [self exchangeSel:@selector(viewWillDisappear:) newSel:@selector(CSJSView_viewWillDisappear:)];
//    [self exchangeSel:@selector(viewDidDisappear:) newSel:@selector(CSJSView_viewDidDisappear:)];
//    [self exchangeSel:@selector(didReceiveMemoryWarning) newSel:@selector(CSJSView_didReceiveMemoryWarning)];
//    
//  });
  
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


+ (instancetype)sourcePath:(NSString *)sourcePath
                    module:(NSString *)module
                initParams:(NSDictionary *)params {
  CSJSViewController *controller = [CSJSViewController new];
  if (controller) {
    JSValue *moduleValue = [CSJSViewEngine executeJSCall:@"ModulesRegistry" method:@"runApplication" arguments:@[module,sourcePath, params]];
    controller.controllerProxy = [[CSJSViewControllerProxy alloc]initWithJSManagedValue:[moduleValue  toString] controller:controller];
    NSLog(@"viewcontroller create %@",controller);
  }
  return controller;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"viewDidLoad" withArguments:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"viewWillAppear" withArguments:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"viewDidAppear" withArguments:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"viewWillDisappear" withArguments:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"viewDidDisappear" withArguments:nil];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
  
  [[CSJSViewEngine jsValueWith:self.controllerProxy.jsAddress] invokeMethod:@"didReceiveMemoryWarning" withArguments:nil];
}

- (void)dealloc {
  [self.controllerProxy clear];
  NSLog(@"viewcontroller release %@",self);
}


@end
