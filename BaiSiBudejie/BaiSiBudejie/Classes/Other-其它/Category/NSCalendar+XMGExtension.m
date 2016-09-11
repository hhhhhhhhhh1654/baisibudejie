//
//  NSCalendar+XMGExtension.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "NSCalendar+XMGExtension.h"

@implementation NSCalendar (XMGExtension)
+(instancetype)calendar{
    
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        // 按住opetion键， 看参数点击进去找到标识符
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        
        return [NSCalendar currentCalendar];
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
























































@end
