//
//  XMGVideoViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGVideoViewController.h"

@interface XMGVideoViewController ()

@end

@implementation XMGVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    XMGLogFunc
    
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
    
    
    //滚动指示条的滚动范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingBlock:^{
        
       XMGLogFunc
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingBlock:^{
        XMGLogFunc
        
    } ];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = XMGRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", [self class], indexPath.row];
    
    return cell;
}


@end