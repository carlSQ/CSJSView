//
//  UIImageView+CSJSView.h
//  CSJSView
//
//  Created by 沈强 on 16/8/19.
//  Copyright © 2016年 沈强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JSExport.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ImageViewJSExport <JSExport>

+ (instancetype)imageViewWithImage:(nullable UIImage *)image frame:(CGRect)frame;

+ (instancetype)imageViewWithImage:(nullable UIImage *)image frame:(CGRect)frame highlightedImage:(nullable UIImage *)highlightedImage;

@property (nullable, nonatomic, strong) UIImage *image; // default is nil
@property (nullable, nonatomic, strong) UIImage *highlightedImage; // default is nil
@property (nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled; // default is NO

@property (nonatomic, getter=isHighlighted) BOOL highlighted; // default is NO

// these allow a set of images to be animated. the array may contain multiple copies of the same

@property (nullable, nonatomic, copy) NSArray<UIImage *> *animationImages; // The array must contain UIImages. Setting hides the single image. default is nil
@property (nullable, nonatomic, copy) NSArray<UIImage *> *highlightedAnimationImages; // The array must contain UIImages. Setting hides the single image. default is nil

@property (nonatomic) NSTimeInterval animationDuration;         // for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
@property (nonatomic) NSInteger      animationRepeatCount;      // 0 means infinite (default is 0)

// When tintColor is non-nil, any template images set on the image view will be colorized with that color.
// The tintColor is inherited through the superview hierarchy. See UIView for more information.
@property (null_resettable, nonatomic, strong) UIColor *tintColor;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end

@interface UIImageView (CSJSView)<ImageViewJSExport>

@end
NS_ASSUME_NONNULL_END
