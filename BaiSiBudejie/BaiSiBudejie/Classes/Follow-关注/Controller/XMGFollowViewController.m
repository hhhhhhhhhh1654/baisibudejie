//
//  XMGFollowViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGFollowViewController.h"

#import "XMGLoginRegisterViewController.h"

#import "XMGRecommendFollowViewController.h"

@interface XMGFollowViewController ()

@end

@implementation XMGFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = XMGCommonBgColor;
    
    //标题
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];

    
    
}

//登录注册按钮
- (IBAction)button:(UIButton *)sender {
    
    XMGLoginRegisterViewController *loginRegister = [[XMGLoginRegisterViewController alloc]init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
    
    
}


-(void)followClick{
    XMGLogFunc
    
    XMGRecommendFollowViewController *follow = [[XMGRecommendFollowViewController alloc]init];
        
    [self.navigationController pushViewController:follow animated:NO];

}





























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
