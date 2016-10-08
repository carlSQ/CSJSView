//
//  CSJSBridgeObjectPool.m
//  CSJSView
//
//  Created by 沈强 on 16/9/30.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSBridgeObjectPool.h"

@interface CSJSBridgeObjectPool ()

@property(nonatomic, strong) NSMapTable *pool;

@end

@implementation CSJSBridgeObjectPool

+ (instancetype)sharedBridgeObjectPool {
  static CSJSBridgeObjectPool *_sharedBridgeObjectPool = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedBridgeObjectPool = [CSJSBridgeObjectPool new];
  });
  return _sharedBridgeObjectPool;
}

- (instancetype)init {
  
  if (self = [super init]) {
    _pool = [NSMapTable strongToStrongObjectsMapTable];
  }
  
  return self;
}

+ (void)setBridgeObjecte:(CSJSBridgeObjecte *)bridgeObjecte
        forUniqueAddress:(NSString *)uniqueAddress {
  [[CSJSBridgeObjectPool sharedBridgeObjectPool].pool setObject:bridgeObjecte forKey:uniqueAddress];
}

+ (CSJSBridgeObjecte *)bridgeObjecteWithUniqueAddress:(NSString *)uniqueAddress {
  
  return [[CSJSBridgeObjectPool sharedBridgeObjectPool].pool objectForKey:uniqueAddress];
  
}

@end
