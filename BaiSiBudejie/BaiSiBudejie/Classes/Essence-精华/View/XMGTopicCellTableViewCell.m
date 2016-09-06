//
//  XMGTopicCellTableViewCell.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/4.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTopicCellTableViewCell.h"

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




@end



@implementation XMGTopicCellTableViewCell
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

    NSDictionary *comment = topic.top_cmt.firstObject;
    
    if (comment) {
        self.topCmtView.hidden = NO;
        NSString *username = comment[@"user"][@"username"];//用户名
        NSString *content = comment[@"content"];//评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@  :  %@", username, content];
        
        
        
    }else{
        
        self.topCmtView.hidden = YES;
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
