//
//  XMGRefreshFooter.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/4.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGRefreshFooter.h"


@implementation XMGRefreshFooter

-(void)prepare{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor redColor];
    
//   [ self addSubview:[UIButton buttonWithType:(UIButtonTypeContactAdd)]];
    
//    
//    
//    /** 是否自动刷新(默认为YES) */
//    @property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;
//    
//    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
//    @property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh MJRefreshDeprecated("请使用automaticallyChangeAlpha属性");
//    
//    /** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
//    @property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;
//    
//    
//    
    
    
    
    
    //刷新控件出现到一半就会进入
    self.triggerAutomaticallyRefreshPercent = -1;
    
    
    
    
    //自动刷新
    self.automaticallyRefresh = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    
//    self.automaticallyHidden = NO;

    
}




@end











