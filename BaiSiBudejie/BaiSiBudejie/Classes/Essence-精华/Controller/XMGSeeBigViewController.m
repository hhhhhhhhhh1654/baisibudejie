//
//  XMGSeeBigViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/16.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGSeeBigViewController.h"

#import <SVProgressHUD.h>



@interface XMGSeeBigViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property(nonatomic, strong) UIImageView *imageView;
@end

@implementation XMGSeeBigViewController
- (IBAction)save {
    
    [self saveAction];
}

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

/**  * 返回一个scrollView的子控件进行缩放  */
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
    
}


- (IBAction)badk {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
