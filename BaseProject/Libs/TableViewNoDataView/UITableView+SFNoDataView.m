//
//  UITableView+SFNoDataView.m
//  Tronker
//
//  Created by 王声远 on 17/3/3.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import "UITableView+SFNoDataView.h"
#import <objc/runtime.h>
#import "SFNonDataView.h"

#define kTableViewIgnoreHeaderFooterViewName @"UIView"

static char enableNoDataViewKey;
static char ignoreTableViewHeaderFooterViewKey;
static char showNoDataWithCreateKey;

@interface UITableView()

//默认是NO,当第一次创建tableView时是否显示无数据页面
@property (assign, nonatomic) BOOL showNoDateViewWhenCreate;

//默认是NO,不启用无数据时的视图显示
@property (assign, nonatomic) BOOL enableNoDataView;

@end

@implementation UITableView (SFNoDataView)

//界面显示
- (SFNonDataView *)noDataView {
    static char nonDataViewKey;
    SFNonDataView *nView = objc_getAssociatedObject(self, &nonDataViewKey);
    if (!nView) {
        nView = [[SFNonDataView alloc]initWithFrame:self.bounds];
        nView.backgroundColor = [UIColor clearColor];
        [self addSubview:nView];
        [nView setMErrorViewImageName:NODATAIMAGENAME];
        
        NSString *key = [NSString stringWithFormat:@"%pkey",&nonDataViewKey];
        [self willChangeValueForKey:key];
        objc_setAssociatedObject(self,
                                 &nonDataViewKey,
                                 nView,
                                 OBJC_ASSOCIATION_RETAIN);
        [self didChangeValueForKey:key];
    }
    return nView;
}

//设置是否创建时显示无数据界面
- (BOOL)showNoDateViewWhenCreate {
    return [objc_getAssociatedObject(self, &showNoDataWithCreateKey) boolValue];
}

- (void)setShowNoDateViewWhenCreate:(BOOL)showNoDateViewWhenCreate {
    [self willChangeValueForKey:@"showNoDataWithCreateKey"];
    objc_setAssociatedObject(self, &showNoDataWithCreateKey,
                             @(showNoDateViewWhenCreate),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"showNoDataWithCreateKey"];
}

//是否启用无数据界面
- (BOOL)enableNoDataView {
    return [objc_getAssociatedObject(self, &enableNoDataViewKey) boolValue];
}

- (void)setEnableNoDataView:(BOOL)enableNoDataView
{
    [self willChangeValueForKey:@"enableNoDataViewKey"];
    objc_setAssociatedObject(self, &enableNoDataViewKey,
                             @(enableNoDataView),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"enableNoDataViewKey"];
}

//是否忽略头部和尾部的视图
- (BOOL)ignoreTableViewHeaderFooterView
{
    return [objc_getAssociatedObject(self, &ignoreTableViewHeaderFooterViewKey) boolValue];
}

- (void)setIgnoreTableViewHeaderFooterView:(BOOL)ignoreTableViewHeaderFooterView
{
    [self willChangeValueForKey:@"ignoreTableViewHeaderFooterViewKey"];
    objc_setAssociatedObject(self, &ignoreTableViewHeaderFooterViewKey,
                             @(ignoreTableViewHeaderFooterView),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ignoreTableViewHeaderFooterViewKey"];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(reloadData);
        SEL swizzledSelector = @selector(my_reloadData);
        [self tableViewExchangeInstanceMethodWithOriginSel:originalSelector newSel:swizzledSelector];
    });
}

- (void)addNoDataViewClickBlock:(void(^)(void))block {
    [self noDataView].pressRefreshButtonBlock = block;
}

- (void)my_reloadData {
    
    if (!self.enableNoDataView) {
        [self my_reloadData];
        return;
    }
    
    if (![self noDataView].hiddenNoDataView) {
        if (!self.showNoDateViewWhenCreate) {
            self.showNoDateViewWhenCreate = YES;
        }
        else if ([self shouldShowNoDataView]) {
            [self nodataViewNeedShow:YES];
        }
        else if (self.noDataView) {
            [self nodataViewNeedShow:NO];
        }
    }
    else {
        if (self.noDataView) {
            [self nodataViewNeedShow:NO];
        }
    }
    [self my_reloadData];
}

- (void) nodataViewNeedShow:(BOOL)show {
    if (!show) {
        [self.noDataView setHidden:YES]; return;
    }
    [[self noDataView] setHidden:NO];
}

/**
 指定显示无数据的ImageName
 */
- (void)setNoDataImageWithName:(NSString *)imageName {
    [self noDataView].mErrorViewImageName = imageName;
}

- (void)setNoDataImageOffsetY:(CGFloat)y
{
    [[self noDataView] setNoDataImageOffsetY:y];
}

- (void)showNoDataView {
    [self noDataView].hiddenNoDataView = NO;
}

- (void)hiddenNoDataView {
    [self noDataView].hiddenNoDataView = YES;
}

- (void)addNoDataViewWithImgName:(NSString *)imgName offsetY:(CGFloat)y clickBlock:(void(^)(void))block {
    self.enableNoDataView = YES;
    [self addNoDataViewClickBlock:block];
    [self setNoDataImageWithName:imgName?:NODATAIMAGENAME];
    [self setNoDataImageOffsetY:y];
}

+ (void) tableViewExchangeInstanceMethodWithOriginSel:(SEL)originalSelector newSel:(SEL)newSelector {
    NSParameterAssert(originalSelector);
    NSParameterAssert(newSelector);
    Class class = [self class];
    if ([class instancesRespondToSelector:originalSelector]) {
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method newMethod = class_getInstanceMethod(class, newSelector);
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

#pragma mark - 通过TableView的代理和协议方法判断是否有数据要显示
- (BOOL)shouldShowNoDataView {
    
    id<UITableViewDataSource> src = self.dataSource;
    id<UITableViewDelegate> delegate = self.delegate;
    NSInteger sections = 1;
    if (src && [src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
        
    }
    
    if (!self.ignoreTableViewHeaderFooterView) {
        if (self.tableHeaderView) {
            if (![NSStringFromClass(self.tableHeaderView.class) isEqualToString:kTableViewIgnoreHeaderFooterViewName]) {
                return NO;
            }
        }
        
        if (self.tableFooterView) {
            if (![NSStringFromClass(self.tableFooterView.class) isEqualToString:kTableViewIgnoreHeaderFooterViewName]) {
                return NO;
            }
        }
    }
    
    
    for (int i = 0; i<sections; ++i) {
        if (!self.ignoreTableViewHeaderFooterView) {
            if (delegate && [delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
                UIView *sectionHeaderView = [delegate tableView:self viewForHeaderInSection:i];
                if (sectionHeaderView) {
                    return NO;
                }
            }
            if (delegate && [delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
                UIView *sectionFooterView = [delegate tableView:self viewForFooterInSection:i];
                if (sectionFooterView) {
                    return NO;
                }
            }
        }
        if (src && [src tableView:self numberOfRowsInSection:i]){
            return NO;
        }
    }
    return YES;
}

@end
