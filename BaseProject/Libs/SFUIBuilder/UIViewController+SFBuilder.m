//
//  UIViewController+SFBuilder.m
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UIViewController+SFBuilder.h"
#import "NSString+SFBuilder.h"

@implementation UIViewController (SFBuilder)

- (BOOL (^)())controllerIsPush {
    return ^(){
        NSArray *viewcontrollers=self.navigationController.viewControllers;
        if (viewcontrollers.count > 1)
        {
            if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
            {
                return YES;
            }
        }
        return NO;
    };
}

- (SFPropertyUIViewControllerObjectBlock)controllerStartImg {
    return ^(id obj) {
        UIImageView *welcomeView = [[UIImageView alloc] init];
        if ([obj isKindOfClass:[UIImage class]]) {
            welcomeView.image = obj;
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            NSString *url = obj;
            if(url.strIsImgUrl()){
                SFLog(@"暂时不支持网络图片");
            }
            else {
                welcomeView.image = [UIImage imageNamed:url];
            }
        }
        
        //添加启动界面
        [welcomeView setFrame:[UIScreen mainScreen].bounds];
        welcomeView.alpha = 0.99;
        UIWindow *w = [UIApplication sharedApplication].keyWindow;
        [w addSubview:welcomeView];
        
        //计算放大
        CGRect f = welcomeView.frame;
        f.size.width = [UIScreen mainScreen].bounds.size.width*1.5;
        f.size.height = [UIScreen mainScreen].bounds.size.height*1.5;
        
        //延迟一下
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //开始动画
            [UIView animateWithDuration:1 animations:^{
                welcomeView.frame = f;
                welcomeView.center = w.center;
                welcomeView.alpha = 0;
            } completion:^(BOOL finished) {
                //动画结束
                [welcomeView removeFromSuperview];
            }];
        });
        return self;
    };
}

@end
