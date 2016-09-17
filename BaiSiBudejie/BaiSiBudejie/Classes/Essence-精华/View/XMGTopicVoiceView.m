//
//  XMGTopicVoiceView.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/11.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import "XMGSeeBigViewController.h"

@interface XMGTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XMGTopicVoiceView

- (void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigBig)]];
    
}

-(void)sigBig{
    
    XMGSeeBigViewController *seeBig = [[XMGSeeBigViewController alloc]init];
    seeBig.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
    
    
}

-(void)setTopic:(XMGTopic *)topic{
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text =  [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime % 60;
    
    //%04zd -占据四位, 空出来的位用0来填补
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    

    
    
}




@end
