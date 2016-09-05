//
//  UITextField+XMGExtension.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/20.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "UITextField+XMGExtension.h"
static NSString * const XMGPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (XMGExtension)

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    //提前设置占位文字， 目的：让它提前创建placeholderLabel
    
    NSString *oldPlacehoder = self.placeholder;
    //因为placeholder有长度时placeholderLabe才会创建
    self.placeholder = @" ";
    self.placeholder = oldPlacehoder;
    
    //恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    
    //设置占位文字的颜色
    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
    
    
}

-(UIColor *)placeholderColor{
    
    
    
    return [self valueForKeyPath:XMGPlaceholderColorKey];
    
}

















@end
