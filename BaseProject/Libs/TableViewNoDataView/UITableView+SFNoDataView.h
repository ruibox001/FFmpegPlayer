//
//  UITableView+SFNoDataView.h
//  Tronker
//
//  Created by 王声远 on 17/3/3.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义默认的图片名称
#define NODATAIMAGENAME @"empty"

@interface UITableView (SFNoDataView)

//默认是NO,不忽略头部和尾部视图
@property (assign, nonatomic) BOOL ignoreTableViewHeaderFooterView;

//设置无数据的界面提示：
//imgName是图片名称
//y图片在Y轴位移
//block点击回调
- (void)addNoDataViewWithImgName:(NSString *)imgName offsetY:(CGFloat)y clickBlock:(void(^)(void))block;

@end
