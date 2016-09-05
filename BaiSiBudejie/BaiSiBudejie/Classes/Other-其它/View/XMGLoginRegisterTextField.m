//
//  XMGLoginRegisterTextField.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/20.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGLoginRegisterTextField.h"
#import "UITextField+XMGExtension.h"
@implementation XMGLoginRegisterTextField

-(void)awakeFromNib{
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //设置默认的占位文字的颜色
    self.placeholderColor = [UIColor grayColor];
    
    self.font = [UIFont systemFontOfSize:18];
    
    

    
    
}



-(BOOL)becomeFirstResponder{
    
    self.placeholderColor = [UIColor whiteColor];
    
    
    return [super becomeFirstResponder];
    
    

    
}


-(BOOL)resignFirstResponder{
    
    self.placeholderColor = [UIColor grayColor];
    
    
    return [super resignFirstResponder];
    
    
    
}











@end
