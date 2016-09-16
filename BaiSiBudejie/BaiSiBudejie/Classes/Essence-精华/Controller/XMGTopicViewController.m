//
//  XMGTopicViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGTopicViewController.h"

#import "XMGTopicCellTableViewCell.h"
#import "XMGHTTPSessionManager.h"

@interface XMGTopicViewController ()

/**
 *  所有帖子的数据
 */
@property(nonatomic, strong) NSMutableArray<XMGTopic *> *topics;

/**
 *  下拉刷新的提示文字
 */
@property(nonatomic, strong) UILabel *label;

/**
 *  maxtime: 用来加载下一页数据
 */

@property(nonatomic, strong) NSString *maxtime;

/**
 *  任务管理者
 */

@property(nonatomic, strong) XMGHTTPSessionManager *manager;



@end

@implementation XMGTopicViewController


static NSString * const XMGTopicCellId = @"topicCell";
#pragma mark - 懒加载
- (XMGHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self setupRefresh];
    
    
    XMGLogFunc
    
    
    
}
- (void)setupTable
{
    
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //滚动指示条的滚动范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    
    
}


- (void)setupRefresh
{
    
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopcis)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

//数据加载
-(void)loadNewTopcis{
    //取消所有的请求
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    //参数
    [self.manager GET:XMGCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //蠢猪maxtiem(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 -> 模型数组
        self.topics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        XMGWriteToPlist(responseObject, @"1111")
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
        
        
        //让控件刷新控件结束刷新
        
        [self.tableView.mj_header endRefreshing];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
    
    
}
-(void)loadMoreTopics{
    
    // 取消所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    [self.manager GET:XMGCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<XMGTopic *> *moreTopics = [XMGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        //        XMGWriteToPlist(responseObject, @"2222")
        
        
        
        // 刷新表格
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XMGLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.topics.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId forIndexPath:indexPath];
    
    cell.topic = self.topics[indexPath.row];
    
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}




-(XMGTopicType)type{
    
    
    return 0;
}









@end
