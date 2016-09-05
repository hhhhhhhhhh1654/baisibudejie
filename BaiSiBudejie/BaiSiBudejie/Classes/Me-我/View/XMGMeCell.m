//
//  XMGMeCell.m
//  BaiSiBudejie
//
//  Created by pro on 16/8/22.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGMeCell.h"

@implementation XMGMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
//        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
        
        
    }
    
    
    return self;
    
    
    
    
    
    
    
    
    
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    
  
    self.imageView.xmg_y = XMGSmallMargin;
    self.imageView.xmg_height = self.contentView.xmg_height-2*XMGSmallMargin;
    self.imageView.xmg_width = self.imageView.xmg_height;
    
    
    
    
    //label
    self.textLabel.xmg_x = self.imageView.xmg_right+XMGMargin;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

































@end
