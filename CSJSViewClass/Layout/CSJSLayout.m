//
//  CSJSLayout.m
//  CSJSView
//
//  Created by 沈强 on 16/8/28.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import "CSJSLayout.h"

static const CGFloat CSJSDefaultScreenWidth = 750.0;

@implementation CSJSLayout

#define CSJS_NUMBER_CONVERT(type, op) \
+ (type)type:(id)value {\
if([value respondsToSelector:@selector(op)]){\
return (type)[value op];\
} else {\
}\
return 0;\
}

CSJS_NUMBER_CONVERT(BOOL, boolValue)
CSJS_NUMBER_CONVERT(int, intValue)
CSJS_NUMBER_CONVERT(short, shortValue
                    )
CSJS_NUMBER_CONVERT(int64_t, longLongValue)
CSJS_NUMBER_CONVERT(uint8_t, unsignedShortValue)
CSJS_NUMBER_CONVERT(uint16_t, unsignedIntValue)
CSJS_NUMBER_CONVERT(uint32_t, unsignedLongValue)
CSJS_NUMBER_CONVERT(uint64_t, unsignedLongLongValue)
CSJS_NUMBER_CONVERT(float, floatValue)
CSJS_NUMBER_CONVERT(double, doubleValue)
CSJS_NUMBER_CONVERT(NSInteger, integerValue)
CSJS_NUMBER_CONVERT(NSUInteger, unsignedIntegerValue)


+ (CGFloat)CGFloat:(id)value
{
  if ([value isKindOfClass:[NSString class]]) {
    NSString *valueString = (NSString *)value;
    if ([valueString hasSuffix:@"px"]) {
      valueString = [valueString substringToIndex:(valueString.length - 2)];
    }
    return [valueString doubleValue];
  }
  
  return [self double:value];
}

+ (CGFloat)WXPixelType:(id)value
{
  CGFloat pixel = [self CGFloat:value];
  
  return pixel * [self screenResizeScale];
}

+ (CGFloat)screenResizeScale
{
  static CGFloat resizeScale;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat deviceWidth;
    if (size.width > size.height) {
      deviceWidth = size.height;
    } else {
      deviceWidth = size.width;
    }
    
    resizeScale = deviceWidth / CSJSDefaultScreenWidth;
  });
  
  return resizeScale;
}


+(css_position_type_t)css_position_type_t:(id)value
{
  if([value isKindOfClass:[NSString class]]){
    if ([value isEqualToString:@"absolute"]) {
      return CSS_POSITION_ABSOLUTE;
    } else if ([value isEqualToString:@"relative"]) {
      return CSS_POSITION_RELATIVE;
    } else if ([value isEqualToString:@"fixed"]) {
      return CSS_POSITION_ABSOLUTE;
    } else if ([value isEqualToString:@"sticky"]) {
      return CSS_POSITION_RELATIVE;
    }
  }
  return CSS_POSITION_RELATIVE;
}

+ (css_flex_direction_t)css_flex_direction_t:(id)value
{
  if([value isKindOfClass:[NSString class]]){
    if ([value isEqualToString:@"column"]) {
      return CSS_FLEX_DIRECTION_COLUMN;
    } else if ([value isEqualToString:@"column-reverse"]) {
      return CSS_FLEX_DIRECTION_COLUMN_REVERSE;
    } else if ([value isEqualToString:@"row"]) {
      return CSS_FLEX_DIRECTION_ROW;
    } else if ([value isEqualToString:@"row-reverse"]) {
      return CSS_FLEX_DIRECTION_ROW_REVERSE;
    }
  }
  return CSS_FLEX_DIRECTION_COLUMN;
}

+ (css_align_t)css_align_t:(id)value
{
  if([value isKindOfClass:[NSString class]]){
    if ([value isEqualToString:@"stretch"]) {
      return CSS_ALIGN_STRETCH;
    } else if ([value isEqualToString:@"flex-start"]) {
      return CSS_ALIGN_FLEX_START;
    } else if ([value isEqualToString:@"flex-end"]) {
      return CSS_ALIGN_FLEX_END;
    } else if ([value isEqualToString:@"center"]) {
      return CSS_ALIGN_CENTER;
    } else if ([value isEqualToString:@"auto"]) {
      return CSS_ALIGN_AUTO;
    }
  }
  
  return CSS_ALIGN_STRETCH;
}

+ (css_wrap_type_t)css_wrap_type_t:(id)value
{
  if([value isKindOfClass:[NSString class]]) {
    if ([value isEqualToString:@"nowrap"]) {
      return CSS_NOWRAP;
    } else if ([value isEqualToString:@"wrap"]) {
      return CSS_WRAP;
    }
  }
  
  return CSS_NOWRAP;
}

+ (css_justify_t)css_justify_t:(id)value
{
  if([value isKindOfClass:[NSString class]]){
    if ([value isEqualToString:@"flex-start"]) {
      return CSS_JUSTIFY_FLEX_START;
    } else if ([value isEqualToString:@"center"]) {
      return CSS_JUSTIFY_CENTER;
    } else if ([value isEqualToString:@"flex-end"]) {
      return CSS_JUSTIFY_FLEX_END;
    } else if ([value isEqualToString:@"space-between"]) {
      return CSS_JUSTIFY_SPACE_BETWEEN;
    } else if ([value isEqualToString:@"space-around"]) {
      return CSS_JUSTIFY_SPACE_AROUND;
    }
  }
  
  return CSS_JUSTIFY_FLEX_START;
}

- (CGRect)frame {
  return CGRectMake([CSJSLayout WXPixelType:@(_cssNode->layout.position[CSS_LEFT])],
             [CSJSLayout WXPixelType:@(_cssNode->layout.position[CSS_TOP])],
             [CSJSLayout WXPixelType:@(_cssNode->layout.position[CSS_WIDTH])],
             [CSJSLayout WXPixelType:@(_cssNode->layout.position[CSS_HEIGHT])]);
}


- (void)_initCSSNodeWithStyles:(NSDictionary *)styles
{
  _cssNode = new_css_node();
  
  _cssNode->print = cssNodePrint;
  _cssNode->get_child = cssNodeGetChild;
  _cssNode->is_dirty = cssNodeIsDirty;
  if ([self measure]) {
    _cssNode->measure = cssNodeMeasure;
  }
  _cssNode->context = (__bridge void *)self;
  [self _fillCSSNode:styles];
}



#define CSJS_STYLE_FILL_CSS_NODE(key, cssProp, type)\
if (styles[@#key]) {\
_cssNode->style.cssProp = (typeof(_cssNode->style.cssProp))[CSJSLayout type:styles[@#key]];\
}


#define CSJS_STYLE_FILL_CSS_NODE_ALL_DIRECTION(key, cssProp, type) \
do {\
CSJS_STYLE_FILL_CSS_NODE(key, cssProp[CSS_TOP], type)\
CSJS_STYLE_FILL_CSS_NODE(key, cssProp[CSS_LEFT], type)\
CSJS_STYLE_FILL_CSS_NODE(key, cssProp[CSS_RIGHT], type)\
CSJS_STYLE_FILL_CSS_NODE(key, cssProp[CSS_BOTTOM], type)\
} while(0);

- (void)_fillCSSNode:(NSDictionary *)styles;
{
  // flex
  CSJS_STYLE_FILL_CSS_NODE(flex, flex, CGFloat)
  CSJS_STYLE_FILL_CSS_NODE(flexDirection, flex_direction, css_flex_direction_t)
  CSJS_STYLE_FILL_CSS_NODE(alignItems, align_items, css_align_t)
  CSJS_STYLE_FILL_CSS_NODE(alignSelf, align_self, css_align_t)
  CSJS_STYLE_FILL_CSS_NODE(flexWrap, flex_wrap, css_wrap_type_t)
  CSJS_STYLE_FILL_CSS_NODE(justifyContent, justify_content, css_justify_t)
  
  // position
  CSJS_STYLE_FILL_CSS_NODE(position, position_type, css_position_type_t)
  CSJS_STYLE_FILL_CSS_NODE(top, position[CSS_TOP], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(left, position[CSS_LEFT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(right, position[CSS_RIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(bottom, position[CSS_BOTTOM], WXPixelType)
  
  // dimension
  CSJS_STYLE_FILL_CSS_NODE(width, dimensions[CSS_WIDTH], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(height, dimensions[CSS_HEIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(minWidth, minDimensions[CSS_WIDTH], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(minHeight, minDimensions[CSS_HEIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(maxWidth, maxDimensions[CSS_WIDTH], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(maxHeight, maxDimensions[CSS_HEIGHT], WXPixelType)
  
  // margin
  CSJS_STYLE_FILL_CSS_NODE_ALL_DIRECTION(margin, margin, WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(marginTop, margin[CSS_TOP], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(marginLeft, margin[CSS_LEFT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(marginRight, margin[CSS_RIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(marginBottom, margin[CSS_BOTTOM], WXPixelType)
  
  // border
  CSJS_STYLE_FILL_CSS_NODE_ALL_DIRECTION(borderWidth, border, WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(borderTopWidth, border[CSS_TOP], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(borderLeftWidth, border[CSS_LEFT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(borderRightWidth, border[CSS_RIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(borderBottomWidth, border[CSS_BOTTOM], WXPixelType)
  
  // padding
  CSJS_STYLE_FILL_CSS_NODE_ALL_DIRECTION(padding, padding, WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(paddingTop, padding[CSS_TOP], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(paddingLeft, padding[CSS_LEFT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(paddingRight, padding[CSS_RIGHT], WXPixelType)
  CSJS_STYLE_FILL_CSS_NODE(paddingBottom, padding[CSS_BOTTOM], WXPixelType)
}

static void cssNodePrint(void *context) {
  
  CSJSLayout *layout = (__bridge CSJSLayout *)context;
  
  printf("frame:x = %f, y = %f, width = %f, height = %f",layout.frame.origin.x, layout.frame.origin.y, layout.frame.size.width, layout.frame.size.height);
  
  for (CSJSLayout *layout  in layout.children) {
    cssNodePrint((__bridge void *)(layout));
  }
  
}

static css_dim_t cssNodeMeasure(void *context, float width)
{
  CSJSLayout *layout = (__bridge CSJSLayout *)context;
  CGSize (^measure)(CGFloat) = [layout measure];
  
  if (!measure) {
    return (css_dim_t){NAN, NAN};
  }
  
  CGSize resultSize = measure(width);
  
  return (css_dim_t){resultSize.width, resultSize.height};
}


static css_node_t * cssNodeGetChild(void *context, int i)
{
  CSJSLayout *layout = (__bridge CSJSLayout *)context;
  
  if(i >= 0 && i < layout.children.count){
    CSJSLayout *child = layout.children[i];
    return child->_cssNode;
  }
  
  return NULL;
}

static bool cssNodeIsDirty(void *context)
{
  return true;
}

@end
