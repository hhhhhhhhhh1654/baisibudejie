//
//  XMGTopicPictureView.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/11.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import <DALabeledCircularProgressView.h>

@interface XMGTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;



@end



@implementation XMGTopicPictureView

- (void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setTopic:(XMGTopic *)topic{
    
    _topic = topic;
    
    self.progressView.hidden = NO;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //reveivedSize :  已经接收到的图片大小
        //expectedSize :  图片的总大小
        CGFloat progress = 1.0*receivedSize/expectedSize;
        self.progressView.progress = progress;
        self.progressView.hidden = NO;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress*100];
        
        NSLog(@" 哈哈哈哈哈哈哈： %f", progress);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        NSLog(@" 隐藏在进度条  ");

        
    }];
    
    //gif图
    self.gifView.hidden = !topic.is_gif;
    
    //查看大图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;

        
        
    }

    
}





































@end
