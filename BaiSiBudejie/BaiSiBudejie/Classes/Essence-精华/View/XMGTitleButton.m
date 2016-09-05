//
//  XMGTitleButton.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTitleButton.h"

@implementation XMGTitleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置按钮颜色
        self.selected = NO;
        
        [self setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        
        self.titleLabel.font = UIPtfont(14);
  
        
    }
    return self;
}


-(void)setHighlighted:(BOOL)highlighted{}



@end
