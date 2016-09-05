//
//  NSString+XMGExtension.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/16.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "NSString+XMGExtension.h"

@implementation NSString (XMGExtension)
//- (unsigned long long)fileSize
//{
//    // 总大小
//    unsigned long long size = 0;
//    
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    
//    // 文件属性
//    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
//    
//    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
//        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
//        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
//        for (NSString *subpath in enumerator) {
//            // 全路径
//            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
//            // 累加文件大小
//            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
//        }
//    } else { // 文件
//        size = attrs.fileSize;
//    }
//    
//    return size;
//}

- (unsigned long long)fileSize
{

    //总大小
    unsigned long long size = 0;
    //文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //是否为文件夹
    BOOL isDirectory = NO;
    
    //路径是否存在
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if (!exists) return size;
    
    if (isDirectory) {//是一个文件夹
        
        //获得文件夹的大小 == 获得文件夹中所有文件的总大小
        
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        for (NSString *subpath in enumerator) {
           //全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];

            //累加文件大小
            
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
            
        }
        
    }else{//是个文件
   
        size = [[mgr attributesOfItemAtPath:self error:nil] fileSize];
  
    }
    
    return size;
}


@end
