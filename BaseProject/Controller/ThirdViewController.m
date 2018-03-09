//
//  ThirdViewController.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "ThirdViewController.h"
#import "SYNavigationHeader.h"
#import "BaseWKWebViewController.h"
#import "UIViewController+TabBar.h"
#import "AppDelegate.h"
#import "UITableView+SFNoDataView.h"
#import "MyModel.h"

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic) UITableView *myTableView;
@property (assign,nonatomic) int number;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNavigationTitle:@"比较" tintColor:[UIColor whiteColor]];
    
    WEAKSELF
    [self addNavigationRight:@[@"刷新0",@"刷新20"] tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index) {
        if (index == 0) {
            weakSelf.number = 0;
            [weakSelf.myTableView reloadData];
        }
        else {
            weakSelf.number = 20;
            [weakSelf.myTableView reloadData];
        }
    }];
    
    [self addNavigationLeft:@"未读5" tintColor:[UIColor whiteColor] clickBlock:^(NSInteger index) {
        [weakSelf tabBarSetUnReadCount:5 withSelectIndex:2];
    }];
    
    get.url(@"http://www.weather.com.cn/data/sk/101110101.html")
    .startWithResolve(@"weatherinfo",@"MyModel",^(id model){
        if ([model isKindOfClass:[NSError class]]) {
            NSLog(@"请求错误了：%@",model);
        }
        else if([model isKindOfClass:[MyModel class]]){
            NSLog(@"解析成功了：%@",model);
        }
        else {
            NSLog(@"解析错误了：%@",model);
        }
    });
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect mainFrame = self.view.bounds;
    mainFrame.origin.y = naviHeight;
    mainFrame.size.height -= (49+naviHeight);
    UITableView *myTableView = [[UITableView alloc] initWithFrame:mainFrame style:UITableViewStylePlain];
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.rowHeight = 44;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView addNoDataViewWithImgName:nil offsetY:0 clickBlock:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *key = @"tableViewId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
    }
    
    cell.textLabel.text = @"大数据";
    
    return cell;
}


- (void)click {
    NSLog(@"click");
}

@end
