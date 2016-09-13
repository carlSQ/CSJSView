//
//  CSJSValueMemory.m
//  CSJSView
//
//  Created by 沈强 on 16/9/11.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSValueMemory.h"

@interface CSJSValueMemory ()
@property(nonatomic, strong) NSMutableDictionary* memory;
@end

@implementation CSJSValueMemory

+ (instancetype)sharedMemory {
  static CSJSValueMemory *_sharedMemory = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedMemory = [CSJSValueMemory new];
  });
  
  return _sharedMemory;
}


- (instancetype)init {
  if (self = [super init]) {
    _memory = [NSMutableDictionary dictionary];
  }
  return self;
}

+ (void)retain:(JSValue *)jsValue {
  [[CSJSValueMemory sharedMemory].memory setObject:jsValue forKey:@([jsValue hash]).stringValue];
}

+ (void)release:(JSValue *)jsValue {
  [[CSJSValueMemory sharedMemory].memory removeObjectForKey:@([jsValue hash]).stringValue];
}

@end
