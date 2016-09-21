//
//  XMGSeeBigViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/16.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGSeeBigViewController.h"
#import "XMGTopic.h"
#import <SVProgressHUD.h>

//#import <AssetsLibrary/AssetsLibrary.h>   //iOS9开始废弃

#import <Photos/Photos.h>

@interface XMGSeeBigViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation XMGSeeBigViewController

static NSString *XMGAssetCollectionTitle = @"YB----嘿嘿嘿嘿嘿嘿";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageViwe
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;//图片下载失败
        self.saveButton.enabled = YES;
        
    }];
    
    [scrollView addSubview:imageView];
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_height = self.topic.height * imageView.xmg_width / self.topic.width;
    imageView.xmg_x = 0;
    
    if (imageView.xmg_height >= scrollView.xmg_height) { //图片高度超过整个屏幕
        imageView.xmg_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
        
    }else{//居中显示
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    
    self.imageView = imageView;
    
    //缩放比例
    CGFloat scale = self.topic.width/imageView.xmg_width;
    
    if (scale > 1.0) {
        
        scrollView.maximumZoomScale = scale;
    }
    


}

- (IBAction)save {
    /**
     *  
     
     PHAuthorizationStatusNotDetermined     用户还没有做出选择
     PHAuthorizationStatusRestricted,       因为家长控制, 导致应用无法选择相册  (跟用户的选择没有关系)
     PHAuthorizationStatusDenied,           用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized        用户允许当前应用访问相册(用户当初点击了"好")

     
     */
    
    
//    [self saveAction];
//    先判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted){
        
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
        
    }else if (status == PHAuthorizationStatusDenied){
        
        XMGLog(@"提醒用户去[设置-隐私-照片-xxxx]打开访问开关");
        
        
    }else if (status == PHAuthorizationStatusAuthorized){
        
        [self saveImage];
        
    }else if (status == PHAuthorizationStatusNotDetermined){
        
        //弹窗请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
           
            if (status == PHAuthorizationStatusAuthorized) {  //用户点击了好
                [self saveImage];
            }
            
        }];
        
        
    }
    
    
}

-(void)saveImage{
    // PAAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection  : 一个相薄
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetlocalIdentifier = nil;
    
    // 如果相对"相册" 进行修改(增删改), 那么修改代码必须放在 [PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中

    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //1、  保存图片A到"相机胶卷"中
        //  创建图片的请求
        
        assetlocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        if (success == NO) {
            [self showErrorWithString:@"图片保存失败"];
            return ;
        }
        
        //2. 获得相薄
        
        PHAssetCollection *createAssetCollection =[self createAssetCollection];
        
        if (createAssetCollection == nil) {
            [self showErrorWithString:@"创建相薄失败！"];
            return;
        }
        // 3. 添加"相机胶卷"中的图片A到"相薄"D中
        
        [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
            
            //获得图片
            
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetlocalIdentifier] options:nil].lastObject;
            
            //添加图片到相薄中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createAssetCollection];
            
            //添加图片到相薄
            
            [request addAssets:@[asset]];
            
            
            
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success == NO) {
                [self showErrorWithString:@"保存图片失败"];
            }else{
                
                [self showSuccessWithStrign:@"保存图片成功"];
            }
            
            
        }];

        
    }];
    
}

/**  * 返回一个scrollView的子控件进行缩放  */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
    
}


- (IBAction)badk {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  获得相薄
 *
 *
 */

-(PHAssetCollection *)createAssetCollection{
 
    
    //从已经存在的相薄中查找这个应用对应的相薄
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:XMGAssetCollectionTitle]) {
            
            return assetCollection;
        }
        
    }
    
    //没有找到对应的相薄, 得创建的新相薄
    //错误信息
    
    NSError *error = nil;
    
    // PHAssetCollection的标示,利用这个标识可以找到对应PHAssetCollection对象(相薄对象)
    
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
     
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:XMGAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;

        
    } error:&error];
    
    
    //如果有错误信息
    if (error) return nil;
    
    //获得刚才创建的相薄
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;

    
}


//保存图片
-(void)saveAction{
    
    // 传入的方法必须是这种格式，有三个参数
    
    // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(a:b:c:), nil);
    
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    XMGLogFunc
    
}

-(void)a:(UIImage *)image b:(NSError *)error c:(void *)contextInfo{

    
    if (error) {

        [self showErrorWithString:@"图片保存失败"];
 
    }else{
        
        [self showSuccessWithStrign:@"图片保存成功"];
        
    }
    
}




/**
 *  通过UIImageWriteToSavePhotosAlbum函数写入图片完毕后就会调用这个方法
 */


// Adds a photo to the saved photos album.  The optional completionSelector should have the form:
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        
        
    }else{
        
        
    }
    
    
}




-(void)showErrorWithString:(NSString *)errorInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showErrorWithStatus:errorInfo];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        });

    });
    
}

-(void)showSuccessWithStrign:(NSString *)successInfo{
    

    dispatch_async(dispatch_get_main_queue(), ^{
        

        [SVProgressHUD showSuccessWithStatus:successInfo];

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            [self dismissViewControllerAnimated:YES completion:nil];

        });
        
    });
    
    
}








































































@end
