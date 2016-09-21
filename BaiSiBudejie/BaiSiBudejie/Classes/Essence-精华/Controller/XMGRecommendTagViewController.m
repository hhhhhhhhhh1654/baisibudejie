//
//  XMGRecommendTagViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/21.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGRecommendTagViewController.h"
#import "XMGHTTPSessionManager.h"
#import "XMGRecommendTag.h"
#import "XMGRecommendTagCell.h"



@interface XMGRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是XMGRecommendTag模型) */
@property (nonatomic, strong) NSArray<XMGRecommendTag *> *recommendTags;
/** 请求管理者 */
@property (nonatomic, weak) XMGHTTPSessionManager *manager;
@end

@implementation XMGRecommendTagViewController
/** manager属性的懒加载 */
- (XMGHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [XMGHTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString * const XMGRecommendTagCellId = @"recommendTag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XMGRecommendTagCellId];
    
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = XMGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendTags.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGRecommendTagCellId];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
