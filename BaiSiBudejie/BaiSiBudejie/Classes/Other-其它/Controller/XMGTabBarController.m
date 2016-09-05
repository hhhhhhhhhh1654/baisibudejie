//
//  XMGTabBarController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGTabBar.h"
#import "XMGEssenceViewController.h"
#import "XMGNewViewController.h"
#import "XMGFollowViewController.h"
#import "XMGMeViewController.h"
#import "XMGNavigationController.h"


@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupItemTitleTextAttributes];
    
    //添加子控制器
    [self setupChildViewControllers];
    
    //更换tabBar
    [self setValue:[[XMGTabBar alloc]init] forKey:@"tabBar"];
    
}

//设置所有UITabBarItem的文字属性
- (void)setupItemTitleTextAttributes
{

    UITabBarItem *item = [UITabBarItem appearance];
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    //设置选中状态下文字属性
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
}
- (void)setupChildViewControllers
{

    
        [self setupOneChildViewController:[[XMGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    
    [self setupOneChildViewController:[[XMGMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

    
    [self setupOneChildViewController:[[XMGFollowViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    

    
    [self setupOneChildViewController:[[XMGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];

    
    
}
/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
 
    
    XMGNavigationController *na = [[XMGNavigationController alloc]initWithRootViewController:vc];
    na.tabBarItem.title = title;
    
    if (image.length) {
        
        na.tabBarItem.image = [UIImage imageNamed:image];
        
        na.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
        
    }
    
    
    [self addChildViewController:na];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
