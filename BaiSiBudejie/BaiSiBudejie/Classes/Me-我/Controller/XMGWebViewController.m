//
//  XMGWebViewController.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/29.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGWebViewController.h"

@interface XMGWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation XMGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.webView goBack];
}
- (IBAction)forward:(UIBarButtonItem *)sender {
    
    [self.webView goForward];
}



- (IBAction)reload:(UIBarButtonItem *)sender {
    
    [self.webView reload];
}













-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
    
}


























@end
