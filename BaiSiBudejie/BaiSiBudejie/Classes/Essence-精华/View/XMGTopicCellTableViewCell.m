//
//  XMGTopicCellTableViewCell.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/4.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTopicCellTableViewCell.h"
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"
#import "XMGComment.h"
#import "XMGUser.h"
@interface XMGTopicCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

//最热评论

@property (weak, nonatomic) IBOutlet UIView *topCmtView;

/**
 *  中间控件   图片控件
 */
@property(nonatomic, strong) XMGTopicPictureView *pictureView;

/** 声音控件 */
@property(nonatomic, strong) XMGTopicVoiceView *voiceView;

/** 声音控件 */

@property(nonatomic, strong) XMGTopicVideoView *videoView;

//中间的view
@property(nonatomic, strong) UIView *conterContentView;



@end



@implementation XMGTopicCellTableViewCell
#pragma mark - 懒加载
- (UIView *)conterContentView
{
 
    if (!_conterContentView) {
        _conterContentView = [[UIView alloc]init];
        
        _conterContentView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_conterContentView];
    }
    
    return _conterContentView;
    
}


- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView viewFromXib];
        _pictureView = pictureView;
 
    }
    _pictureView.frame = _conterContentView.bounds;

    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView viewFromXib];
         _voiceView = voiceView;
  
    }
    _voiceView.frame = _conterContentView.bounds;

    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView viewFromXib];
         _videoView = videoView;
 
    }
    _videoView.frame = _conterContentView.bounds;

     return _videoView;
}



- (IBAction)more {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        XMGLog(@"点击了收藏按钮");
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

-(void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;  //调用get方法
    self.text_label.text = topic.text;
    

    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];

  
    if (topic.top_cmt) {
        
        self.topCmtView.hidden = NO;
        NSString *username = topic.top_cmt.user.username;//用户名
        NSString *content = topic.top_cmt.content;//评论内容
       self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@  :  %@", username, content];

    }else{//没有最热评论时
        
        self.topCmtView.hidden = YES;
    }
    
    self.conterContentView.frame = topic.contentF;
    [self.conterContentView removeAllSubViews];
    
    //中间内容
   if (topic.type == XMGTopicTypeVideo) {
   
       [self.conterContentView addSubview:self.videoView];
       self.videoView.topic = topic;
       
    
       NSLog(@"%zd %@  %@",self.conterContentView.subviews.count, self.conterContentView.logframe, self.videoView.logframe);
       
   } else if (topic.type == XMGTopicTypeVoice) { // 音频
       
       [self.conterContentView addSubview:self.voiceView];
       self.voiceView.topic = topic;
       
   } else if (topic.type == XMGTopicTypeWord) { // 段子

       
   } else if (topic.type == XMGTopicTypePicture) { // 图片
 
       [self.conterContentView addSubview:self.pictureView];
       self.pictureView.topic = topic;

    }
    

    
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
-(void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
    
    // 最热评论 不能用if (topic.top_cmt)
    // if (topic.top_cmt.count) { // 有最热评论
    
    
    
    
}


/**
 *  重写这个方法的目的：能够拦截所有cell frame操作
 
 */

-(void)setFrame:(CGRect)frame{
    
    frame.size.height = frame.size.height - XMGMargin;
    
    frame.origin.y += XMGMargin;
    
    [super setFrame:frame];
    
    
    
}































@end
