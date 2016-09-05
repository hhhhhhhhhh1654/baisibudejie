//
//  XMGEssenceViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/18.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"
#import "XMGTitleButton.h"


@interface XMGEssenceViewController ()<UIScrollViewDelegate>

/** 当前选中的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self setupNav];
    
    [self setupChildViewControllers];
    
    [self setupScollView];
    
    [self setupTitlesView];
    
    //默认添加子控制器
    [self addChildVcView];
    
    
}

-(void)setupNav{
    
    self.view.backgroundColor = XMGCommonBgColor;
    
    //标题
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

-(void)setupChildViewControllers{
    
    XMGAllViewController *all = [[XMGAllViewController alloc] init];
    [self addChildViewController:all];
    
    XMGVideoViewController *video = [[XMGVideoViewController alloc] init];
    [self addChildViewController:video];
    
    XMGVoiceViewController *voice = [[XMGVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    XMGPictureViewController *picture = [[XMGPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    XMGWordViewController *word = [[XMGWordViewController alloc] init];
    [self addChildViewController:word];
    
    
}


-(void)setupScollView{
    
    //不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = XMGRandomColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //添加所有子控制器的view到scorllview
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * Kwidth, 0);
    //添加所有的子控制器的View到scrollView中
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}
- (void)setupTitlesView
{

    //标题栏
    UIView *titlesView = [[UIView alloc]init];
    //设置颜色的透明度
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    //添加标题
    NSArray *titles =  @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.xmg_width / count;
    CGFloat titleButtonH = titlesView.xmg_height;
    for (NSUInteger i = 0; i < count; i++) {
        //创建
        XMGTitleButton *titleButton = [XMGTitleButton buttonWithType:(UIButtonTypeCustom)];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titlesView addSubview:titleButton];
        
        //设置数据
        [titleButton setTitle:titles[i] forState:(UIControlStateNormal)];
        
        //设置frame
        titleButton.frame = CGRectMake(i*titleButtonW, 0, titleButtonW, titleButtonH);
    }

    //按钮选中颜色
    XMGTitleButton *firstTileButton = titlesView.subviews.firstObject;
    
    //底部的指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [firstTileButton titleColorForState:(UIControlStateSelected)];
    indicatorView.xmg_height = 1;
    indicatorView.xmg_y = titlesView.xmg_height-indicatorView.xmg_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    
    //立刻根据文字内容计算label的宽度
    [firstTileButton.titleLabel sizeToFit];
    indicatorView.xmg_width = firstTileButton.titleLabel.xmg_width;
    indicatorView.xmg_centerX = firstTileButton.xmg_centerX;
    
    
    //默认情况： 选中最前面的标题按钮
    firstTileButton.selected = YES;
    self.selectedTitleButton = firstTileButton;
    
}

-(void)addChildVcView{
    
    //子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.xmg_width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    //    if (childVc.view.superview) return;
    //    if (childVc.view.window) return;
    if([childVc isViewLoaded]) return;
    
//    
//
//    childVc.view.xmg_x = index *self.scrollView.xmg_width;
//    childVc.view.xmg_y = 0;
//    childVc.view.xmg_width = self.scrollView.xmg_width;
//    childVc.view.xmg_height = self.scrollView.xmg_height;

//    childVc.view.xmg_x = self.scrollView.contentOffset.x;
//    childVc.view.xmg_y = self.scrollView.contentOffset.y;
//    childVc.view.xmg_width = self.scrollView.xmg_width;
//    childVc.view.xmg_height = self.scrollView.xmg_height;
   
//    childVc.view.xmg_x = self.scrollView.bounds.origin.x;
//    childVc.view.xmg_y = self.scrollView.bounds.origin.y;
//    childVc.view.xmg_width = self.scrollView.bounds.size.width;
//    childVc.view.xmg_height = self.scrollView.bounds.size.height;
//
//    childVc.view.frame = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//    
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
    
}

#pragma mark - 监听点击

-(void)titleClick:(XMGTitleButton *)titleButton{
    
    //控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    //指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.xmg_width = titleButton.titleLabel.xmg_width;
        self.indicatorView.xmg_centerX = titleButton.xmg_centerX;
  
    }];
    
    // 让UIScrollView 滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.xmg_width;
    
    [self.scrollView setContentOffset:offset animated:YES];
    
}

-(void)tagClick{
    
    
    XMGLogFunc
}

#pragma mark - <UIScrollViewDelegate>

/*
 在scrollView 滚动到动画结束时，就会调用这个方法
 前提： 使用setContentOffset:animated: 或者scrollRectVisible:aniated:方法让scrollView产生滚动动画
 */

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self addChildVcView];
    
}

/*
 在scrollView 滚动动画结束时, 就会调用这个方法
 
 前提： 认为拖拽scrollView 产生的滚动动画
 
 */

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //选中 点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    
    [self titleClick:titleButton];
    
    // 添加子控制器的view
    [self addChildVcView];
    
    // 当index == 0时，viewWithTag:方法返回的就是self.titleView
    //根据tag值找某个控件，先找父控件, 然后找子控件，找到了一个对应的tag值, 返回
    

}


@end
