//
//  ZBShareMenuView.m
//  MessageDisplay
//
//  Created by zhoubin@moshi on 14-5-13.
//  Copyright (c) 2014年 Crius_ZB. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MessagePhotoView.h"
#import "ZYQAssetPickerController.h"
#import "AS_Sheet.h"


// 每行有4个
#define kZBMessageShareMenuPerRowItemCount 4
#define kZBMessageShareMenuPerColum 2

#define kZBShareMenuItemIconSize 60
#define KZBShareMenuItemHeight 80

#define MaxItemCount 1
#define ItemWidth 84
#define ItemHeight 128


@interface MessagePhotoView (){
    //UILabel *lblNum;
}


/**
 *  这是背景滚动视图
 */
@property(nonatomic,strong) UIScrollView *photoScrollView;
@property (nonatomic, weak) UIScrollView *shareMenuScrollView;
@property (nonatomic, weak) UIPageControl *shareMenuPageControl;
@property(nonatomic,weak)UIButton *btnviewphoto;
@end

@implementation MessagePhotoView
@synthesize photoMenuItems;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)photoItemButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectePhotoMenuItem:atIndex:)]) {
        NSInteger index = sender.tag;
        //        NSLog(@"self.photoMenuItems.count is %d",self.photoMenuItems.count);
        if (index < self.photoMenuItems.count) {
            [self.delegate didSelectePhotoMenuItem:[self.photoMenuItems objectAtIndex:index] atIndex:index];
        }
    }
}

- (void)setup{
    
    self.backgroundColor = [UIColor colorWithRed:248.0f/255 green:248.0f/255 blue:255.0f/255 alpha:1.0];
    
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    //    _photoScrollView.contentSize = CGSizeMake(1024, 124);
    
    photoMenuItems = [[NSMutableArray alloc]init];
    _itemArray = [[NSMutableArray alloc]init];
    [self addSubview:_photoScrollView];
    //lblNum = [[UILabel alloc]initWithFrame:CGRectMake(50, 270, 230, 30)];
    
    //[self addSubview:lblNum];
    
    [self initlizerScrollView:self.photoMenuItems];
    
}

-(void)reloadDataWithImage:(UIImage *)image{
    [self.photoMenuItems addObject:image];
    
    [self initlizerScrollView:self.photoMenuItems];
}

-(void)initlizerScrollView:(NSArray *)imgList{
    [self.photoScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger countNum;
    if (kScreenWidth > 350) {
        countNum = 4;
    }
    else{
        countNum = 3;
    }
    
    for(int i=0;i<imgList.count;i++){
        id sender = imgList[i];
        ALAsset *asset = nil;
        UIImage *tempImg = nil;
        
        if ([sender isKindOfClass:[ALAsset class]]) {
            asset = (ALAsset *)sender;
            tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
        else if ([sender isKindOfClass:[UIImage class]]){
            tempImg = (UIImage *)sender;
        }
        if (!tempImg) {
            return;
        }
        
        xx = 10 + i * (ItemWidth + 5);
        if (i >= countNum && i < countNum * 2) {
            xx = 10 + (i - countNum) * (ItemWidth + 5);
            yy = ItemHeight + 2;
        }
        else if (i >= countNum){
            xx = 10 + (i - countNum * 2) * (ItemWidth + 5);
            yy = ItemHeight * 2 + 2;
        }
        else{
            xx = 10 + i * (ItemWidth + 5);
            yy = 2;
        }
        
        MessagePhotoMenuItem *photoItem = [[MessagePhotoMenuItem alloc]initWithFrame:CGRectMake(xx+10, yy, ItemWidth, ItemHeight)];
        photoItem.delegate = self;
        photoItem.index = i;
        photoItem.contentImage = tempImg;
        [self.photoScrollView addSubview:photoItem];
        [self.itemArray addObject:photoItem];
    }
    
    if(imgList.count<MaxItemCount){
        MessagePhotoMenuItem *photoItem = (MessagePhotoMenuItem *)[self.itemArray lastObject];
        
        UIButton *btnphoto=[UIButton buttonWithType:UIButtonTypeCustom];
        //        [btnphoto setFrame:CGRectMake(20 + (ItemWidth + 5) * imgList.count, 20, 84, 84)];//
        [btnphoto setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [btnphoto setImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateSelected];
        [btnphoto setBackgroundColor:WHITE_COLOR];
        [btnphoto addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
        [self.photoScrollView addSubview:btnphoto];
        
        if (imgList.count == 0) {
            [btnphoto setFrame:CGRectMake(20 + (ItemWidth + 5) * imgList.count, 20, 84, 84)];
        }
        else{
            NSInteger index = photoItem.index + 1;
            if (!((index) / countNum)) {
                [btnphoto setFrame:CGRectMake(20 + (ItemWidth + 5) * imgList.count, 2, 84, 84)];
            }
            else{
                NSInteger chu = index / countNum;
                NSInteger yu = index % countNum;
                
                if (0 == yu) {
                    [btnphoto setFrame:CGRectMake(20, 2 * ItemHeight, 84, 84)];
                }
                else{
                    [btnphoto setFrame:CGRectMake(20 + (ItemWidth + 5) * yu, chu * ItemHeight, 84, 84)];
                }
            }
        }
    }
    
    //    lblNum.text = [NSString stringWithFormat:@"已选%lu张，共可选9张",(unsigned long)self.photoMenuItems.count];
    //    lblNum.backgroundColor = [UIColor clearColor];
}

-(void)openMenu{
    //收起键盘
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //在这里呼出下方菜单按钮项
//    myActionSheet = [[UIActionSheet alloc]
//                     initWithTitle:nil
//                     delegate:self
//                     cancelButtonTitle:@"取消"
//                     destructiveButtonTitle:nil
//                     otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
//    //刚才少写了这一句
//    [myActionSheet showInView:self.window];
    
    AS_Sheet *_sheet = [[AS_Sheet alloc] initWithFrame:(CGRect){0,0,kScreenWidth,kScreenHeight} titleArr:@[@"拍照", @"相册选择"]];
    @weakify(_sheet);
    _sheet.Click = ^(NSInteger clickIndex) {
        @strongify(_sheet);
        if (!self) {
            return;
        }
        switch (clickIndex) {
            case 0:
                NSLog(@"拍照");
                [self takePhoto];
                break;
            case 1:
                NSLog(@"相册选择");
                [self localPhoto];
                break;
            default:
                break;
        }
        [_sheet hiddenSheet];
    };
    [self.viewController.view addSubview:_sheet];
    
}
/*
//下拉菜单的点击响应事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self localPhoto];
            break;
        default:
            break;
    }
}
*/
//开始拍照
-(void)takePhoto{
    if ([self.delegate respondsToSelector:@selector(didCamera)]) {
        [self.delegate didCamera];
    }
}

/*
 新加的另外的方法
 */
////////////////////////////////////////////////////////////
//打开相册，可以多选
-(void)localPhoto{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc]init];
    
    picker.maximumNumberOfSelection = MaxItemCount - self.photoMenuItems.count;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    
    [self.delegate addPicker:picker];
}


/*
 得到选中的图片
 */
#pragma mark - ZYQAssetPickerController Delegate
//-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    if (assets.count <= 0) {
        [PhoneNotification autoHideWithText:@"您还没有选择您的照片"];
        return;
    }
    for (ALAsset *set in assets) {
        //NSLog(@"%@",set.defaultRepresentation.url);
        CGImageRef ref = [[set defaultRepresentation]fullScreenImage];
        
        //UIImage *img = [[UIImage alloc]initWithCGImage:ref];
        picker.sendingImg = [UIImage imageWithCGImage:ref];
    }
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    ShowBigViewController *big = [[ShowBigViewController alloc]init];
    [big setDelegate:self];
    big.isCameraIn = NO;
    big.arrayOK = [NSMutableArray arrayWithArray:assets];
    
    [picker pushViewController:big animated:YES];
    
}
/////////////////////////////////////////////////////////





//选择某张照片之后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self reloadDataWithImage:image];
        
        NSData *datas;
        if(UIImagePNGRepresentation(image)==nil){
            datas = UIImageJPEGRepresentation(image, 1.0);
        }else{
            datas = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //把刚才图片转换的data对象拷贝至沙盒中,并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:datas attributes:nil];
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
        
        //创建一个选择后图片的图片放在scrollview中
        
        //加载scrollview中
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadData {
    [self initlizerScrollView:self.photoMenuItems];
}
- (void)dealloc {
    //self.shareMenuItems = nil;
    //    self.photoScrollView.delegate = self;
    //    self.shareMenuScrollView.delegate = self;
    self.shareMenuScrollView = nil;
    self.shareMenuPageControl = nil;
}

#pragma mark - MessagePhotoItemDelegate

-(void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView didSelectDeleteButtonAtIndex:(NSInteger)index{
    [self.photoMenuItems removeObjectAtIndex:index];
    [self initlizerScrollView:self.photoMenuItems];
}

- (void)didTouchImage:(MessagePhotoMenuItem *)sender{
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([_delegate respondsToSelector:@selector(didBigImage:)]) {
        [_delegate didBigImage:sender.index];
    }
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.shareMenuPageControl setCurrentPage:currentPage];
}


#pragma mark ShowBigViewControllerDelegate
- (void)selectedImageDone:(NSMutableArray *)imageArr{
    [self.photoMenuItems addObjectsFromArray:imageArr];
    [self reloadData];
}

@end
