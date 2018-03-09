//
//  SYTabBarController.m
//  SYFrameWork
//
//  Created by 王声远 on 17/3/10.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYTabBarController.h"
#import "SecondViewController.h"

#define IPhoneWidth [UIScreen mainScreen].bounds.size.width

@interface SYTabBarController ()

@property (strong, nonatomic) UIImageView *tabBarView;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation SYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
     
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (NSMutableArray *)itemModels {
    if (!_itemModels) {
        _itemModels = [NSMutableArray array];
    }
    return _itemModels;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSMutableArray *)rootControllers {
    if (!_rootControllers) {
        _rootControllers = [NSMutableArray array];
    }
    return _rootControllers;
}


#pragma mark - 自定义TabBar
- (void) customTabBarItemView:(UIColor *)bgColor
{
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  self.tabBar.frame.size.width,  self.tabBar.frame.size.height)];
    _tabBarView.userInteractionEnabled = YES;
    [_tabBarView setBackgroundColor:bgColor];
    [self.tabBar addSubview:_tabBarView];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tabBarView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
    [_tabBarView addSubview:lineView];

    int itemWidth = IPhoneWidth/self.itemModels.count;
    for (int index = 0; index < self.itemModels.count; index++) {
        
        SYTabBarModel *m = [self.itemModels objectAtIndex:index];
        SYTabBarButtonItem *button = [[SYTabBarButtonItem alloc]initWithFrame:CGRectMake(index*itemWidth, m.tarBarOffsetY, itemWidth, _tabBarView.frame.size.height) itemInfo:m];
        button.tag = index;
        [button addTarget:self action:@selector(tabBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        if (index == self.selectedIndex) {
            [button setSelected:YES];
        }
        [_tabBarView addSubview:button];
        [button reloadData];
        
        [self.items addObject:button];
    }
    [self.tabBar bringSubviewToFront:_tabBarView];
}

- (void) tabBarItemClick:(SYTabBarButtonItem *)button
{
    NSInteger index = button.tag;
    
    if(self.shouldSelectTabBarItemBlock){
        BOOL should = self.shouldSelectTabBarItemBlock(index);
        if (!should) {
            return;
        }
    }
    
    if (self.selectedIndex == index) {
        return;
    }
    
    for (SYTabBarButtonItem *item in self.items) {
        if (item.tag != index) {
            [item setSelected:NO];
            [button reloadData];
        }
    }
    
    self.selectedIndex = index;
    [button setSelected:YES];
    [button reloadData];
}

/**
 设置未读数
 @param count 未读数
 */
- (void) setTabBarItemUnReadCount:(int)count {
    SYTabBarButtonItem *buttonItem = self.items[self.selectedIndex];
    if (buttonItem) {
        buttonItem.model.tarBarUnReadCount = count;
        [buttonItem reloadData];
    }
}
/**
 设置未读数
 @param count 未读数
 @param selectedIndex 第几个tarBar
 */
- (void) setTabBarItemUnReadCount:(int)count selectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex >= self.itemModels.count) {
        return;
    }
    SYTabBarButtonItem *buttonItem = self.items[selectedIndex];
    if (buttonItem) {
        buttonItem.model.tarBarUnReadCount = count;
        [buttonItem reloadData];
    }
}

/**
 选中当前tarBar
 @param selectIndex tarBar位置
 */
- (void) selectTabBarWithIndex:(NSInteger)selectIndex
{
    if (selectIndex >= self.itemModels.count) {
        return;
    }
    
    if (self.selectedIndex == selectIndex) {
        return;
    }
    
    self.selectedIndex = selectIndex;
    
    for (SYTabBarButtonItem *item in self.items) {
        if (item.tag != selectIndex) {
            [item setSelected:NO];
        }
        else {
            [item setSelected:YES];
        }
        [item reloadData];
    }
}

- (void)pushToControllerWithController:(UIViewController *)controller withIndex:(NSInteger)index
{
    UIViewController *nav = self.rootControllers[index];
    [nav.navigationController pushViewController:controller animated:YES];
}

@end
