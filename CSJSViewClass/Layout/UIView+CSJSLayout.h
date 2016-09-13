//
//  UIView+CSJSLayout.h
//  CSJSView
//
//  Created by 沈强 on 16/8/31.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSJSLayout.h"

@interface UIView (CSJSLayout)

@property(nonatomic, strong)NSDictionary *cssStyle;

- (void)calculateLayout;

@end
