//
//  CSJSInteraction.h
//  CSJSView
//
//  Created by 沈强 on 16/10/10.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CSJSInteraction <NSObject>
- (void)updateVar:(id)var forKey:(NSString *)key;
- (id)varForKey:(NSString *)key;
@end
