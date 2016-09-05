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
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
