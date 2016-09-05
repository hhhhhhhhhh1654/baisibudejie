//
//  XMGTabBar.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTabBar.h"

@interface XMGTabBar ()


@property(nonatomic, strong) UIButton *publishButton;
@end



@implementation XMGTabBar

/**
 发布按钮
 
 - retur
 */

-(UIButton *)publishButton{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;

}








#pragma mark -初始化
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
    }
    
    
    return self;
    
}


/**
 *  初始化子控件
 */

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat buttonW = self.xmg_width/5;
    CGFloat buttonH = self.xmg_height;
    
    CGFloat tabBarButtonY = 0;
    
    int tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        
        //过滤非uitabbarUBtton
        
        
        if (subview.class != NSClassFromString(@"UITabBarButton")) {
            continue;
        }
        
        //设置frame
        
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        
        if (tabBarButtonIndex >= 2) {
            
            tabBarButtonX += buttonW;
            
            
        }
        
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        //增加索引
        
        tabBarButtonIndex++;
    
    }
    
    
    //设置发布按钮的frame
    
    self.publishButton.xmg_width = buttonW;
    self.publishButton.xmg_height = buttonH;
    self.publishButton.xmg_centerX = self.xmg_width * 0.5;
    self.publishButton.xmg_centerY = self.xmg_height * 0.5;
    
    
    
    
    
    
}



-(void)publishClick{
    
 
    
}












@end
