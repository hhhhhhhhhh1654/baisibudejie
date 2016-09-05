//
//  XMGQuickLoginButton.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/20.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGQuickLoginButton.h"

@implementation XMGQuickLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.xmg_y = 0;
    
    self.imageView.xmg_centerX = self.xmg_width*0.5;
    
    
    
    
    self.titleLabel.xmg_x = 0;
    
    
    self.titleLabel.xmg_y = self.imageView.xmg_bottom;
    
    self.titleLabel.xmg_height = self.xmg_height-self.titleLabel.xmg_y;
    self.titleLabel.xmg_width = self.xmg_width;

}























@end
