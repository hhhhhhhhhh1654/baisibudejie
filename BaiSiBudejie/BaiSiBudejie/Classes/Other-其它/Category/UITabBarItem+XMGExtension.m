//
//  UITabBarItem+XMGExtension.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "UITabBarItem+XMGExtension.h"

@implementation UIBarButtonItem (XMGExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
                                                 
    [button setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:highImage] forState:(UIControlStateSelected)];
    
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    [button sizeToFit];
    
    
    return [[self alloc]initWithCustomView:button];

    
    
}

























@end
