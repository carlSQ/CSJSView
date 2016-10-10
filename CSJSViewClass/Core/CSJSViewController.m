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
#import "CSJSBridgeObjectPool.h"

@interface CSJSViewController ()

@property(nonatomic, strong)NSMutableDictionary *vars;

@end

@implementation CSJSViewController

+ (instancetype)sourcePath:(NSString *)sourcePath
                    module:(NSString *)module
                initParams:(NSDictionary *)params {
  
  CSJSViewController *controller = [CSJSViewController new];
  
  if (controller) {
    JSValue *moduleValue = [CSJSViewEngine executeJSCall:@"ModulesRegistry" method:@"runApplication" arguments:@[module,sourcePath, params]];
    controller.jsAddress = [moduleValue  toString];
    [CSJSBridgeObjectPool setBridgeObjecte:controller forUniqueAddress:controller.jsAddress];
    NSLog(@"viewcontroller create %@",controller);
  }
  
  return controller;
}

- (instancetype)init {
  
  if (self = [super init]) {
    _vars = [NSMutableDictionary dictionary];
  }
  
  return self;
}

- (void)updateVar:(id)var forKey:(NSString *)key {
  [_vars setValue:var forKey:key];
}

- (id)varForKey:(NSString *)key {
  if ([key isEqualToString:@"self"]) {
    return self;
  }
  return [_vars valueForKey:key];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"viewDidLoad" withArguments:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"viewWillAppear" withArguments:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"viewDidAppear" withArguments:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"viewWillDisappear" withArguments:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"viewDidDisappear" withArguments:nil];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
  
  [[CSJSViewEngine jsValueWith:self.jsAddress] invokeMethod:@"didReceiveMemoryWarning" withArguments:nil];
}

- (void)dealloc {
  [CSJSViewEngine releaseJSValueWith:self.jsAddress];
  NSLog(@"viewcontroller release %@",self);
}


@end
