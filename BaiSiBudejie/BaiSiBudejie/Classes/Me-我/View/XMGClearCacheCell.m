//
//  XMGClearCacheCell.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/2.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGClearCacheCell.h"

#import <SDImageCache.h>

#import <SVProgressHUD.h>



#define XMGCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@implementation XMGClearCacheCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        //设置右边的指示器（用来说明正在处理一些事情)
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [loadingView startAnimating];
        
        self.accessoryView = loadingView;
        
        //谁值cell 默认文字(如果设置文字之前userInteractionEnable=NO,那么文字会自动变成浅灰色)
        self.textLabel.text = @"清楚缓存（正在计算缓存大小）....";
        
        //禁止点击
        self.userInteractionEnabled = NO;
        
         __weak typeof(self) weakSelf = self;
        
        //在子线程计算缓存大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:4.0];
            //获得缓存文件夹路径
            
            unsigned long long size = XMGCustomCacheFile.fileSize;
            
            size += [SDImageCache sharedImageCache].getSize;
            
            //如果cell已经销毁了，就直接返回
      
            if (weakSelf == nil) {
                return ;
            }
            
            NSString *sizeText = nil;
            
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            //生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
            
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                weakSelf.textLabel.text = text;
                // 清空右边的指示器
                weakSelf.accessoryView = nil;
                // 显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                // 添加手势监听器
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                // 恢复点击事件
                weakSelf.userInteractionEnabled = YES;
            });
            
  
        });

        
        
    }
    
    
    
    
    
    return  self;
}

- (void)clearCache
{
    // 弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType:SVProgressHUDMaskTypeBlack];
    
//    [SVProgressHUD showWithStatus:@"哈哈哈"];
//    [SVProgressHUD showProgress:0.8]; //进度条
//    [SVProgressHUD showImage:[UIImage imageNamed:@"mine-my-post"] status:@"天津科技大小"];
//    [SVProgressHUD showInfoWithStatus:@"天津可继续"];
//     [SVProgressHUD showErrorWithStatus:@"发生错误"];
//    [SVProgressHUD showSuccessWithStatus:@"已经成功全局孙斐瑾"];
    
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:XMGCustomCacheFile error:nil];
            [mgr createDirectoryAtPath:XMGCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
//                [SVProgressHUD dismiss];
                
                // 设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}







- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //滑动talbeview cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
    
    
}









@end
