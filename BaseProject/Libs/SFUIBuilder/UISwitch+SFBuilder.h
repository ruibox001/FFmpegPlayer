//
//  UISwitch+SFBuilder.h
//  Tronker
//
//  Created by 王声远 on 2017/4/24.
//  Copyright © 2017年 Shenzhen Soffice Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define swicht [UISwitch new]

@interface UISwitch (SFBuilder)

SF_UISWITCH_PROP(Bool) switchValue;
SF_UISWITCH_PROP(Object) switchOnColor;
SF_UISWITCH_PROP(Object) switchTinColor;
SF_UISWITCH_PROP(Object) switchThumbColor;

SF_UISWITCH_PROP(Object) switchOnImg;
SF_UISWITCH_PROP(Object) switchOffImg;

@end
