//
//  SYPhotoViewController.h
//  SYPhotoBrowser
//
//  Created by Sunnyyoung on 16/3/30.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "DACircularProgressView.h"

@interface SYPhotoViewController : UIViewController

@property (nonatomic, strong, readonly) id imageSource;
@property (nonatomic, assign, readonly) NSUInteger pageIndex;

- (instancetype)initWithImageSouce:(id)imageSouce pageIndex:(NSUInteger)pageIndex;
- (void)resetImageSize;

@end
