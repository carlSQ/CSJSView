//
//  CSJSLayout.h
//  CSJSView
//
//  Created by 沈强 on 16/8/28.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Layout.h"

@interface CSJSLayout : NSObject


typedef NS_ENUM(NSInteger, FlexDirection) {
  FlexDirectionColumn = CSS_FLEX_DIRECTION_COLUMN,
  FlexDirectionRow = CSS_FLEX_DIRECTION_ROW,
  FlexDirectionRowReverse = CSS_FLEX_DIRECTION_ROW_REVERSE,
  FlexDirectionColumnReverse = CSS_FLEX_DIRECTION_COLUMN_REVERSE
};

typedef NS_ENUM(NSInteger, Justification) {
  JustificationFlexStart = CSS_JUSTIFY_FLEX_START,
  JustificationCenter = CSS_JUSTIFY_CENTER,
  JustificationFlexEnd = CSS_JUSTIFY_FLEX_END,
  JustificationSpaceBetween = CSS_JUSTIFY_SPACE_BETWEEN,
  JustificationSpaceAround = CSS_JUSTIFY_SPACE_AROUND
};

typedef NS_ENUM(NSInteger, SelfAlignment) {
  SelfAlignmentAuto = CSS_ALIGN_AUTO,
  SelfAlignmentFlexStart = CSS_ALIGN_FLEX_START,
  SelfAlignmentCenter = CSS_ALIGN_CENTER,
  SelfAlignmentFlexEnd = CSS_ALIGN_FLEX_END,
  SelfAlignmentStretch = CSS_ALIGN_STRETCH
};

typedef NS_ENUM(NSInteger, ChildAlignment) {
  ChildAlignmentFlexStart = CSS_ALIGN_FLEX_START,
  ChildAlignmentCenter = CSS_ALIGN_CENTER,
  ChildAlignmentFlexEnd = CSS_ALIGN_FLEX_END,
  ChildAlignmentStretch = CSS_ALIGN_STRETCH,
};

@property (nonatomic, weak, readonly) UIView *view;

@property (nonatomic, readonly, assign) css_node_t *cssNode;

@property (nonatomic, readonly, assign) CGRect frame;

@property (nonatomic, copy) CGSize (^measure)(CGFloat);

@property (nonatomic, copy) NSArray *children;

@end
