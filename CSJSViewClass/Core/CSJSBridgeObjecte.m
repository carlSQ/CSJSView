//
//  CSJSBridgeObjected.m
//  CSJSView
//
//  Created by 沈强 on 16/9/30.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSBridgeObjecte.h"
#import "CSJSBridgeObjectPool.h"

@interface CSJSBridgeObjecte ()

@end

@implementation CSJSBridgeObjecte

+ (instancetype)bridgeObjectedWithUniqueAddress:(NSString *)uniqueAddress {
  
  CSJSBridgeObjecte *bridgeObject = [[CSJSBridgeObjecte alloc] initWithUniqueAddress:uniqueAddress];
  
  [CSJSBridgeObjectPool setBridgeObjecte:bridgeObject forUniqueAddress:uniqueAddress];
  
  return bridgeObject;
}

- (instancetype)initWithUniqueAddress:(NSString *)uniqueAddress {
  
  if (self = [super init]) {
    _uniqueAddress = uniqueAddress;
    _strongVar = [NSMutableDictionary dictionary];
    _weakVar = [NSMapTable strongToWeakObjectsMapTable];
  }
  
  return self;
}

@end
