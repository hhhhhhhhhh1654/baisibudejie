//
//  XMGSettingViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/22.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGSettingViewController.h"
#import "XMGTestViewController.h"
#import <SDImageCache.h>


#import "XMGClearCacheCell.h"
#import "XMGOtherCell.h"

@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController
static NSString * const XMGClearCacheCellId = @"XMGClearCacheCell";
static NSString * const XMGSettingCellId = @"XMGSettingCell";
static NSString * const XMGOtherCellId = @"XMGOtherCell";
-(instancetype)init{
    
    
    
    return [self initWithStyle:UITableViewStyleGrouped];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XMGCommonBgColor;
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[XMGClearCacheCell class] forCellReuseIdentifier:XMGClearCacheCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XMGSettingCellId];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGOtherCell class]) bundle:nil] forCellReuseIdentifier:XMGOtherCellId];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    XMGTestViewController *text = [[XMGTestViewController alloc]init];
    
    [self.navigationController pushViewController:text animated:NO];
    
    
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    if (section == 1) return 5;
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清除缓存cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        //        XMGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
        //
        //        // cell重新显示的时候, 继续转圈圈
        //        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)cell.accessoryView;
        //        [loadingView startAnimating];
        //
        //        return cell;
        
        return [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
        
    } else if (indexPath.row == 2) {
        //        XMGOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGOtherCellId];
        //        cell.data = data;
        //        return cell;
        
        return [tableView dequeueReusableCellWithIdentifier:XMGOtherCellId];
    }
    
    // 其他cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGSettingCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[XMGOtherCell class]]) {
        
    }
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
