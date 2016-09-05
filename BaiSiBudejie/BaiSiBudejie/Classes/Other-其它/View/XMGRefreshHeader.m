//
//  XMGRefreshHeader.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/4.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGRefreshHeader.h"


@interface XMGRefreshHeader()

@property(nonatomic, strong) UIImageView *logo;


@end


@implementation XMGRefreshHeader

/*
 
 初始化
 */


-(void)prepare{
    
    [super prepare];
    
    //自动改变透明度
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.stateLabel.textColor = [UIColor orangeColor];
 
//    /** 普通闲置状态 */
//    MJRefreshStateIdle = 1,
//    /** 松开就可以进行刷新的状态 */
//    MJRefreshStatePulling,
//    /** 正在刷新中的状态 */
//    MJRefreshStateRefreshing,
//    /** 即将刷新的状态 */
//    MJRefreshStateWillRefresh,
//    /** 所有数据加载完毕，没有更多的数据了 */
//    MJRefreshStateNoMoreData
//    
    
    [self setTitle:@"赶紧下拉吧" forState:(MJRefreshStateIdle)];
    [self setTitle:@"赶紧松开吧" forState:(MJRefreshStatePulling)];
    [self setTitle:@"正在加载数据....." forState:(MJRefreshStateRefreshing)];
    
//    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
    [self addSubview:[[UISwitch alloc]init]];
    
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image = [UIImage imageNamed:@"11111.jpg"];
    [self addSubview:logo];
    self.logo = logo;

    
}

/**
 *  播放子控件
 */
-(void)placeSubviews{
    
    [super placeSubviews];
    
    self.logo.xmg_width = self.xmg_width;
    self.logo.xmg_height = 50;
    self.logo.xmg_x = 0;
    self.logo.xmg_y = -30;
    
}





















































@end
