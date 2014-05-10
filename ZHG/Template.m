//
//  Template.m
//  ZHG
//
//  Created by lihong on 14-5-9.
//  Copyright (c) 2014年 LiHong(410139419@qq.com). All rights reserved.
//

#import "Template.h"
#import "UIImageView+WebCache.h"

@implementation Template

- (void)setWith:(ProductDetailTemplate *)pdt
{
    NSArray *templateData = [pdt getTemplateData];
    NSInteger min = MIN(self.subviews.count, templateData.count);
    for(NSInteger i = 0; i < min; i++)
    {
        UIView *v = self.subviews[i];
        if([[v class] isSubclassOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)v;
            [imageView setImageWithURL:[NSURL URLWithString:templateData[i]]];
        }
        else if([[v class] isSubclassOfClass:[UIWebView class]])
        {
            UIWebView *webView = (UIWebView *)v;
            [webView loadHTMLString:templateData[i] baseURL:nil];
        }
    }
}

@end
