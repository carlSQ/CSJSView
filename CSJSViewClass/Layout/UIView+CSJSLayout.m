//
//  UIView+CSJSLayout.m
//  CSJSView
//
//  Created by 沈强 on 16/8/31.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "UIView+CSJSLayout.h"
#import <objc/runtime.h>

@implementation UIView (CSJSLayout)


- (void)setCssStyle:(NSDictionary *)cssStyle {
  NSDictionary *styles = objc_getAssociatedObject(self, _cmd);
  if (styles) {
    [[styles mutableCopy] addEntriesFromDictionary:cssStyle];
  } else {
    objc_setAssociatedObject(self, _cmd, cssStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
}


- (void)setLayout:(CSJSLayout *)layout {
  
  objc_setAssociatedObject(self, _cmd, layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  
}

- (CSJSLayout *)layout {
  
 return objc_getAssociatedObject(self, @selector(setLayout:));
  
}

- (void)calculateLayout {
  layoutNode(self.layout.cssNode,CSS_UNDEFINED,CSS_UNDEFINED);
}

@end
