//
//  UITextField+SFBuilder.h
//  SFFrameWork
//
//  Created by 王声远 on 17/3/14.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUIBuilderDef.h"

#define TextField   [UITextField new]

@interface UITextField (SFBuilder)

SF_UITEXTFIELD_PROP(Object) textFieldColor;

SF_UITEXTFIELD_PROP(Object) textFieldDelegat;

SF_UITEXTFIELD_PROP(Object) textFieldPlaceHoder;

SF_UITEXTFIELD_PROP(Empty) textFieldNullLeftView;

SF_UITEXTFIELD_PROP(Int) textFieldClearBtnMode;

SF_UITEXTFIELD_PROP(Object) textFieldFont;

SF_UITEXTFIELD_PROP(Object) textFieldLeftView;

SF_UITEXTFIELD_PROP(Object) textFieldRightView;

SF_UITEXTFIELD_PROP(Float) textFieldLeftViewOffset;

SF_UITEXTFIELD_PROP(Object) textFieldFinishBtn;

SF_UITEXTFIELD_PROP(Object) textFieldPlaceholderColor;

SF_UITEXTFIELD_PROP(Object) textFieldPlaceholderFont;

SF_UITEXTFIELD_PROP(Int) textFieldKeyType;

@end
