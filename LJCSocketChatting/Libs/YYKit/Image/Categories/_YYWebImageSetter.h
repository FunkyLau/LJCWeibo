//
//  _YYWebImageSetter.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/7/15.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#if __has_include(<YYKit/YYKit.h>)
#import <YYKit/YYWebImageManager.h>
#else
#import "YYWebImageManager.h"
#endif

extern NSString *const _YYWebImageFadeAnimationKey;
extern const NSTimeInterval _YYWebImageFadeTime;
extern const NSTimeInterval _YYWebImageProgressiveFadeTime;

/**
 Private class used by web image categories.
 Typically, you should not use this class directly.
 */
@interface _YYWebImageSetter : NSObject
/// Current image url.
@property (nonatomic, readonly) NSURL *imageURL;

/// Create new operation for web image.
- (void)setOperationWithSentinel:(int32_t)sentinel
                             url:(NSURL *)imageURL
                         options:(YYWebImageOptions)options
                         manager:(YYWebImageManager *)manager
                        progress:(YYWebImageProgressBlock)progress
                       transform:(YYWebImageTransformBlock)transform
                      completion:(YYWebImageCompletionBlock)completion;

/// Cancel and return a sentinel value. The imageURL will be set to nil.
- (int32_t)cancel;

/// Cancel and return a sentinel value. The imageURL will be set to new value.
- (int32_t)cancelWithNewURL:(NSURL *)imageURL;


- (BOOL)isLoading;
/// A queue to set operation.
+ (dispatch_queue_t)setterQueue;

@end
