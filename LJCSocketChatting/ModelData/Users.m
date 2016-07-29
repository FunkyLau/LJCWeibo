//
//  Users.m
//  weibo
//
//  Created by 嘉晨刘 on 6/2/15.
//  Copyright (c) 2015 嘉晨刘. All rights reserved.
//

#import "Users.h"
NSString * const kUserProfileImageDidLoadNotification = @"com.alamofire.user.profile-image.loaded";
@interface Users ()


//#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
//@property (readwrite, nonatomic, strong) AFHTTPRequestOperation *avatarImageRequestOperation;
//#endif
@end
@implementation Users
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    
    if (self) {
        self = [super init];
    }
    
    //self.userID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
    self.usersId = (NSUInteger)[[attributes valueForKeyPath:@"showMessages.messages.users.usersId"] integerValue];
    //self.username = [attributes valueForKeyPath:@"username"];
    self.usersNikename = [attributes valueForKeyPath:@"showMessages.messages.usersNikeName"];
    //self.avatarImageURLString = [attributes valueForKeyPath:@"avatar_image.url"];
    self.avatarImageURL = [attributes valueForKeyPath:@"pictures.picturesUrl"];
    
    return self;
}


/*
#pragma mark -

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED

+ (NSOperationQueue *)sharedProfileImageRequestOperationQueue {
    static NSOperationQueue *_sharedProfileImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProfileImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_sharedProfileImageRequestOperationQueue setMaxConcurrentOperationCount:8];
    });
    
    return _sharedProfileImageRequestOperationQueue;
}

- (NSImage *)profileImage {
    if (!_profileImage && !_avatarImageRequestOperation) {
        NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:self.avatarImageURL];
        //[mutableRequest setValue:@"image/*" forHTTPHeaderField:@"Accept"];
        [mutableRequest setValue:@"uploadImage/" forHTTPHeaderField:@"Accept"];
        AFHTTPRequestOperation *imageRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:mutableRequest];
        imageRequestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [imageRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSImage *responseImage) {
            self.profileImage = responseImage;
            
            _avatarImageRequestOperation = nil;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserProfileImageDidLoadNotification object:self userInfo:nil];
        } failure:nil];
        
        [imageRequestOperation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
            return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
        }];
        
        _avatarImageRequestOperation = imageRequestOperation;
        
        [[[self class] sharedProfileImageRequestOperationQueue] addOperation:_avatarImageRequestOperation];
    }
    
    return _profileImage;
}

#endif
*/
@end
