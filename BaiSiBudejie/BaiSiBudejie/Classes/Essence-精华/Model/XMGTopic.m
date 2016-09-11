//
//  XMGTopic.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/14.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGTopic.h"
#import "NSCalendar+XMGExtension.h"
#import "NSDate+XMGExtension.h"
#import "XMGComment.h"
#import "XMGUser.h"

@implementation XMGTopic
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

+(void)initialize{
    fmt_ = [[NSDateFormatter alloc]init];
    calendar_ = [NSCalendar calendar];
    
}


-(NSString *)created_at{
    
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *creteAtDate = [fmt_ dateFromString:_created_at];
    if (creteAtDate.isThisYear) {
        
        if (creteAtDate.isToday) {  //今天
            //手机当前时间
            
            NSDate *nowDate = [NSDate date];
    
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar_ components:unit fromDate:creteAtDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) {//时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];

                
            }else{
                
                return @"刚刚";
            }
            
            
            
            
            
            
        }else if (creteAtDate.isYesterday){//昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:creteAtDate];
            
        }else{
            
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:creteAtDate];
            
        }
        
        
        
        
        
    }else{
        
        return _created_at;
    }
    
    
    
    
    return nil;
    
}

// 屏幕宽度 == 375
// 图片显示出来的宽度 == 355
// 图片显示出来的高度 == 355 * 300 / 710

// 服务器返回的图片宽度 == 710
// 服务器返回的图片高度 == 300

-(CGFloat)cellHeight{
    //如果cell高度已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    //1.头像
    _cellHeight = 55;
    
    //文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * XMGMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIPtfont(15)} context:nil].size;
    _cellHeight += textSize.height+XMGMargin;
    
        self.contentF = CGRectMake(XMGMargin, _cellHeight, 0, 0);
    //3. 中间的内容
    if (self.type != XMGTopicTypeWord) {//如果不是文字内容(图片\声音\视频帖子),才需要计算中间内容的高度
        //中间内容的高度=中间内容的宽度*图片的真是高度/图片的真是宽度
        CGFloat contentH = textMaxW * self.height/self.width;
        if (contentH>=Kheight) {
            //将超长图片高度变为200;
            contentH = 200;
            self.bigPicture = YES;
            
        }
        //这里的cellHeight 就是中间内容的y值
        self.contentF = CGRectMake(XMGMargin, _cellHeight, textMaxW, contentH);
        
        //累加中间内容的高度
        _cellHeight += contentH + XMGMargin;

    }
    //4.  最热评论
    if (self.top_cmt) {
        //最热评论-标题
        _cellHeight += 20;
        //最热评论-内容
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height+XMGMargin;
    }

    //5、底部-工具条
    _cellHeight += 35+XMGMargin;
    
    return _cellHeight;

}



















































@end