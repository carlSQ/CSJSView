//
//  CSJSBridgeObjectPool.h
//  CSJSView
//
//  Created by 沈强 on 16/9/30.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSJSBridgeObjecte.h"

@interface CSJSBridgeObjectPool : NSObject

+ (void)setBridgeObjecte:(CSJSBridgeObjecte *)bridgeObjecte
        forUniqueAddress:(NSString *)uniqueAddress;

+ (CSJSBridgeObjecte *)bridgeObjecteWithUniqueAddress:(NSString *)uniqueAddress;

@end
