//
//  CSJSBridgeObjected.h
//  CSJSView
//
//  Created by 沈强 on 16/9/30.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSJSBridgeObjecte : NSObject

@property(nonatomic,copy, readonly)NSString *uniqueAddress;

@property(nonatomic, strong)NSMutableDictionary *strongVar;

@property(nonatomic, strong)NSMapTable *weakVar;

+ (instancetype)bridgeObjectedWithUniqueAddress:(NSString *)uniqueAddress;

@end
