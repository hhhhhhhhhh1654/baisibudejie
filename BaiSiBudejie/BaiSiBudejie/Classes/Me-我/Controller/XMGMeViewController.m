//
//  XMGMeViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSettingViewController.h"
#import "XMGMeFooterView.h"

#import "XMGMeCell.h"

@interface XMGMeViewController ()

@end

@implementation XMGMeViewController
-(instancetype)init{
    
    
    return [self initWithStyle:UITableViewStyleGrouped];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    


 [self setupTable];

  [self setupNav];
}

- (void)setupTable
{
    
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XMGMargin;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XMGMargin-35, 0, 0, 0);
    

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[XMGMeFooterView alloc]init];
    
    
}

- (void)setupNav
{
   //标题
    self.navigationItem.title = @"我的";
    
    //右边-设置
    UIBarButtonItem *setteignItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];


    //右边-月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];


    self.navigationItem.rightBarButtonItems = @[setteignItem, moonItem];
    

}

- (void)settingClick
{
    XMGLogFunc
    
    
    XMGSettingViewController *setting = [[XMGSettingViewController alloc]init];
    
    [self.navigationController pushViewController:setting animated:YES];
    
  
}

- (void)moonClick
{
    XMGLogFunc
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"me";
    
    XMGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!cell) {
        cell = [[XMGMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
        
    }else{
       
        cell.textLabel.text = @"离线下载";
        cell.imageView.image = nil;
        
    }
    

    
    return cell;
    
}












@end
