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
    controller.controllerProxy = [[CSJSViewControllerProxy alloc]initWithJSManagedValue:moduleValue controller:controller];
    NSLog(@"viewcontroller create %@",controller);
  }
  return controller;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"GO" style:UIBarButtonItemStylePlain target:self action:@selector(go)];
  JSValue *view = [self.controllerProxy.jsManagedValue invokeMethod:@"viewDidLoad" withArguments:nil];
  [self.view addSubview:[view toObject]];
}

- (void)go {
  [self.navigationController pushViewController:[CSJSViewController sourcePath:@"Layout.js" module:@"Layout" initParams:@{@"key":@"hello word"}] animated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.controllerProxy.jsManagedValue invokeMethod:@"viewWillAppear" withArguments:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self.controllerProxy.jsManagedValue invokeMethod:@"viewDidAppear" withArguments:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self.controllerProxy.jsManagedValue invokeMethod:@"viewWillDisappear" withArguments:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.controllerProxy.jsManagedValue invokeMethod:@"viewDidDisappear" withArguments:nil];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
  
  [self.controllerProxy.jsManagedValue invokeMethod:@"didReceiveMemoryWarning" withArguments:nil];
}

- (void)dealloc {
  [self.controllerProxy clear];
  _controllerProxy = nil;
  NSLog(@"viewcontroller release %@",self);
}


@end
