//
//  UITableView+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define TableViewPlain   [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain]
#define TableViewGroup   [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]

@interface UITableView (SFBuilder)

SF_UITABLEVIEW_PROP(Object) tabViewDelegat;

SF_UITABLEVIEW_PROP(Object) tabViewDataSouce;

SF_UITABLEVIEW_PROP(Object) tabViewHeaderView;

SF_UITABLEVIEW_PROP(Object) tabViewFooterView;

SF_UITABLEVIEW_PROP(Bool) tabViewShowsVerticalIndicator;

SF_UITABLEVIEW_PROP(Bool) tabViewShowsHorizontalIndicator;

SF_UITABLEVIEW_PROP(Int) tabViewSeparatorStyle;

SF_UITABLEVIEW_PROP(Int) tabViewReloadWithRow;

@end
