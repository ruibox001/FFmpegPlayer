//
//  UIViewController+SFBuilder.h
//  Tronker
//
//  Created by 王声远 on 2017/4/28.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

@interface UIViewController (SFBuilder)

//判断当前ViewController是push还是present的方式显示的
- (BOOL (^)())controllerIsPush;

SF_UIViewController_PROP(Object) controllerStartImg;

@end
