//
//  XMGMeFooterView.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/23.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGMeFooterView.h"
#import "XMGMeSquareButton.h"
#import "XMGMeSquare.h"

#import "XMGWebViewController.h"
#import <SafariServices/SafariServices.h>

@interface XMGMeFooterView ()

@end


@implementation XMGMeFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        NSMutableDictionary *parms = [NSMutableDictionary dictionary];
        parms[@"a"] = @"square";
        parms[@"c"] = @"topic";
        
        //请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parms progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            [responseObject writeToFile:@"/Users/pro/Desktop/1111.plist" atomically:YES];
            
            NSArray *squares = [XMGMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
        
        
        
        
        
        
    }
    
    return self;

    
    
}

//根据模型数据创建对应控件
-(void)createSquares:(NSArray *)squares{
    
    //个数
    NSInteger count = squares.count;
    
    //方块尺寸
    NSInteger maxColsCount = 4;//行
    CGFloat buttonW = self.xmg_width/maxColsCount;
    
    CGFloat buttonH = buttonW;
    
    
    for (NSUInteger i = 0; i < count; i++) {
        //创建按钮
        XMGMeSquareButton *button = [XMGMeSquareButton buttonWithType:(UIButtonTypeCustom)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:button];
        
        button.xmg_x = (i % maxColsCount) * buttonW;
        
        button.xmg_y = (i / maxColsCount) * buttonH;
        
        button.xmg_height = buttonH;
        button.xmg_width = buttonW;
        
        button.square = squares[i];
        
    }
    
    //设置footer的高度 == 最后一个按钮的bottom(最大Y值）
    self.xmg_height = self.subviews.lastObject.xmg_bottom;
    
    //设置tableview的contentSize
    
    UITableView *tableView = (UITableView *)self.superview;
//    重新刷新数据(会重新计算contentSize)
    tableView.tableFooterView = self;
    
    
    [tableView reloadData];
    

    
}






-(void)buttonClick:(XMGMeSquareButton *)button{
    NSString *url = button.square.url;
    if ([url hasPrefix:@"http"]) {
        
        
//        SFSafariViewController *webView = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:url]];
//        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
//        [tabBarVc presentViewController:webView animated:YES completion:nil];
//        
        //获得 我 模块对应的导航控制器
        
//        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        
//        UINavigationController *nav = tabBarVc.childViewControllers.firstObject;
      
        
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        
        UINavigationController *nav = tabBarVc.selectedViewController;
        
        XMGWebViewController *webView = [[XMGWebViewController alloc]init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
        
        
        
        
        
        
        
    }else if ([url hasPrefix:@"mod"]){//另行处理
        if ([url hasSuffix:@"BDJ_To_Check"]) {
           
            XMGLog(@"跳转到审帖界面");
            
            
        }else if ([url hasSuffix:@"BDJ_To_RecentHot"]){
            
            XMGLog(@"跳转到每日排行界面");
            
        }else{
            
            XMGLog(@"跳转到其它界面");
            
        }
        
        
        
        
        
        
        
    }else{
        
        
        
        XMGLog(@"不是http或者mod协议的");

        
    }
    
    
    
    
    
    
    
}























@end
