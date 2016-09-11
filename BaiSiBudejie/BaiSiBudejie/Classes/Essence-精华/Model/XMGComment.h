//
//  XMGComment.h
//  BaiSiBudejie
//
//  Created by pro on 16/9/11.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGUser;

@interface XMGComment : NSObject

/** 内容*/

@property(nonatomic, strong) NSString  *content;

/** 用户(发表评论的人)*/
@property(nonatomic, strong) XMGUser *user;












































@end
