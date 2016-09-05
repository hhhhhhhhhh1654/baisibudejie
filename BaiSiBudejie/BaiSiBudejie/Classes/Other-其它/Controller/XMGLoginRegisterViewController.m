//
//  XMGLoginRegisterViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/20.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"

@interface XMGLoginRegisterViewController ()

//距离左边的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation XMGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
        return UIStatusBarStyleLightContent;
    
}


/**
 *  关闭当前界面
 */

- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  显示登录\注册界面
 */
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    //先退出键盘
    [self.view endEditing:YES];
    
    //设置约束和按钮
    if (self.leftMargin.constant) { //目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0; //只是更改了模型之，并没有对话
        sender.selected = NO;
        
        
    }else{// 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = -self.view.xmg_width;
        sender.selected = YES;
        
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
       
        
        //强制刷新：设置刷新值得约束马上应用到UI控件上
        
        //会刷新self.view内部所有的子控件
        [self.view layoutIfNeeded];
        
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
