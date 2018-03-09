//
//  UITableView+SFBuilder.m
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "UITableView+SFBuilder.h"

@implementation UITableView (SFBuilder)

- (SFPropertyUITableViewObjectBlock)tabViewDelegat {
    return ^ (id delegat) {
        if (delegat) {
            self.delegate = delegat;
        }
        return self;
    };
}

- (SFPropertyUITableViewObjectBlock)tabViewDataSouce {
    return ^ (id dataSouce) {
        if (dataSouce) {
            self.dataSource = dataSouce;
        }
        return self;
    };
}

- (SFPropertyUITableViewObjectBlock)tabViewHeaderView {
    return ^ (id headerView) {
        self.tableHeaderView = headerView;
        return self;
    };
}

- (SFPropertyUITableViewObjectBlock)tabViewFooterView {
    return ^ (id footerView) {
        self.tableFooterView = footerView;
        return self;
    };
}

- (SFPropertyUITableViewBoolBlock)tabViewShowsVerticalIndicator {
    return ^ (BOOL show) {
        self.showsVerticalScrollIndicator = show;
        return self;
    };
}

- (SFPropertyUITableViewBoolBlock)tabViewShowsHorizontalIndicator {
    return ^ (BOOL show) {
        self.showsHorizontalScrollIndicator = show;
        return self;
    };
}

- (SFPropertyUITableViewIntBlock)tabViewSeparatorStyle {
    return ^ (NSInteger separatorStyl) {
        self.separatorStyle = separatorStyl;
        return self;
    };
}

- (SFPropertyUITableViewIntBlock)tabViewReloadWithRow
{
    return ^(NSInteger row) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        if (cell != nil) {
            NSArray *array = [NSArray arrayWithObject:indexPath];
            [self reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
        }
        return self;
    };
}

@end
