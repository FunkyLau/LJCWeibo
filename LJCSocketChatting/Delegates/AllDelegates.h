//
//  AllDelegates.h
//  LJCSocketChatting
//
//  Created by 嘉晨刘 on 2016/12/28.
//  Copyright © 2016年 嘉晨刘. All rights reserved.
//

#ifndef AllDelegates_h
#define AllDelegates_h

@class ZYQAssetPickerController;
@class ShowBigViewController;

@protocol OpenCameraDelegate <NSObject>

-(void)openCamera;

@end

@protocol OpenPhotoPickerDelegate <NSObject>

-(void)openPicker:(ZYQAssetPickerController *)picker;

@end

@protocol DidBigImageDelegate <NSObject>

-(void)openBigImage:(ShowBigViewController *)bigVC;

@end


#endif /* AllDelegates_h */
