//
//  SecondViewController.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SecondViewController.h"
#import "SYAlertBuilder.h"
#import "SYTabBarMaker.h"
#import "SYScrollImageView.h"
#import "SYNavigationHeader.h"
#import "AppDelegate.h"
#import "SFAppStatusManager.h"
#import "BaseWKWebViewController.h"
#import "SYTabBarController.h"
#import "IJKPlayerViewController.h"

@interface SecondViewController ()

@property (nonatomic,strong) NSArray<NSString *> *array;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAKSELF
    
    [self addNavigationTitle:@"标题2" tintColor:[UIColor whiteColor]];
    
    [self addNavigationLeft:@"FFmpeg" tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index) {
        IJKPlayerViewController *v = [[IJKPlayerViewController alloc] init];
        [weakSelf.navigationController pushViewController:v animated:YES];
    }];
    
    [self addNavigationRight:@[[UIImage imageNamed:@"back_white"],[UIImage imageNamed:@"back_white"]] tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index){
        NSLog(@"right click: %ld",(long)index);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *v = scrollImageUnLimit.addUrls(@[@"http://p2.so.qhimgs1.com/t019f0a9e88ea82026e.jpg"]).scrollBlock(^(NSInteger index){
        
    }).click(^(NSInteger index){
        
    }).second(2).addUrl(@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489653619810&di=3f4a1e5cd74e046107f86e2beb7b236c&imgtype=0&src=http%3A%2F%2Fscimg.jb51.net%2Ftouxiang%2F201703%2F2017031520341425.jpg").indicatorOffset(2).indicatorNormalColor([UIColor redColor]).indicatorCurrentColor([UIColor blueColor]).indicatorStyle(ScrollImageIndicatorStyleLine).srollFrame(CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.5));
    [self.view addSubview:v];
    
    [SFAppStatusManager registerObserver:self appEnterBackgroupBlock:^{
        DLog(@"registerObserver appEnterBackgroupBlock");
    }];
    [SFAppStatusManager registerObserver:self appWillEnterForegroundBlock:^{
        DLog(@"registerObserver appWillEnterForegroundBlock");
    }];
    
    [self tabBarSetUnReadCount:25 withSelectIndex:2];
    
    UIButton *btn = Button.btnFont(Fnt(@14)).btnNorTitle(@"dfsf");
    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^(id _) {
        NSLog(@"button was pressed!");
        return [RACSignal empty];
    }];
}

@end
