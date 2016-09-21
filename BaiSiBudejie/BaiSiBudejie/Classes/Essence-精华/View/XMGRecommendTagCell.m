//
//  XMGRecommendTagCell.m
//  BaiSiBudejie
//
//  Created by pro on 16/9/21.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGRecommendTagCell.h"

#import "XMGRecommendTag.h"

@interface XMGRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;

@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end



@implementation XMGRecommendTagCell
- (IBAction)buttonAction:(UIButton *)sender {
}

-(void)setRecommendTag:(XMGRecommendTag *)recommendTag{
    
    _recommendTag = recommendTag;
    
    
    
    
    
    
    
    
    
}


@end
